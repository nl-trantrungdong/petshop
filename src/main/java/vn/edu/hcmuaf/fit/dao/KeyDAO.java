package vn.edu.hcmuaf.fit.dao;

import vn.edu.hcmuaf.fit.beans.PublicKey;
import vn.edu.hcmuaf.fit.db.DBProperties;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class KeyDAO {
    public KeyDAO() {
    }
    private Connection connectDB() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
//            return DriverManager.getConnection("jdbc:mysql://localhost:3306/petshopdb", "root", "");
            return DriverManager.getConnection("jdbc:mysql://"+ DBProperties.getDbHost() +":" + DBProperties.getDbPort() + "/"+DBProperties.getDbName(), DBProperties.getUsername(), DBProperties.getPassword());
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            throw new SQLException("Unable to connect to the database.", e);
        }
    }
    public PublicKey getPublicKey(String userID, String date){ // 20130260-Hoàng Trung Hiếu
        try {
            Connection connection = connectDB();
            String sql = "SELECT * FROM public_key WHERE user_id = ? AND (created_at < ? AND expired_at > ?) ";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userID);
            preparedStatement.setString(2, date);
            preparedStatement.setString(3, date);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                return new PublicKey(resultSet.getInt("id"),
                        resultSet.getString("user_id"),
                        resultSet.getString("publicKey"),
                        resultSet.getString("created_at"),
                        resultSet.getString("expired_at"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
    public boolean isValidKey(String userID) { // 20130252-Trần Nhựt Hào
        Map<String, String> map = new HashMap<>();
        try (Connection connection = connectDB()) {
            // Tạo câu truy vấn SQL với PreparedStatement
            String sql = "SELECT pk.publicKey, pk.expired_at FROM public_key pk WHERE pk.user_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, userID);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    // Kiểm tra xem có kết quả hay không
                    while (resultSet.next()) {
                        map.put(resultSet.getString("publicKey"), resultSet.getString("expired_at"));
                    }
                }
            }

            for (Map.Entry<String, String> entry : map.entrySet()) {
                String date = entry.getValue().split("\\s+")[0];
                if (date.equals("9999-12-31")) {
                    return true;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }
    public boolean insertPublicKey(String userID, String publicKey){  //20130252-Trần Nhựt Hào
        try (Connection connection = connectDB()) {
            // Tạo câu truy vấn SQL với PreparedStatement
            String sql = "INSERT INTO public_key (user_id, publicKey, created_at, expired_at) VALUES (?, ?, CURRENT_TIMESTAMP, '9999-12-31')";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                // Thiết lập giá trị cho tham số trong câu truy vấn
                preparedStatement.setString(1, userID);
                preparedStatement.setString(2, publicKey);
                preparedStatement.executeUpdate();
            }catch (Exception e){
                return false;
            }
        } catch (SQLException e) {
            return false;
//            throw new RuntimeException(e);
        }
        return true;
    }
    public boolean reportKey(String userID){  //20130230-trần trung đông
        try (Connection connection = connectDB()) {
            // Tạo câu truy vấn SQL với PreparedStatement
            String sql = "UPDATE public_key SET expired_at =CURRENT_TIMESTAMP WHERE public_key.user_id=? AND public_key.expired_at='9999-12-31 00:00:00'";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                // Thiết lập giá trị cho tham số trong câu truy vấn
                preparedStatement.setString(1, userID);
                preparedStatement.executeUpdate();
            }catch (Exception e){
                return false;
            }
        } catch (SQLException e) {
            return false;
//            throw new RuntimeException(e);
        }
        return true;
    }

    public static void main(String[] args) {
        String key="MIIDQzCCAjUGByqGSM44BAEwggIoAoIBAQCPeTXZuarpv6vtiHrPSVG28y7FnjuvNxjo6sSWHz79NgbnQ1GpxBgzObgJ58KuHFObp0dbhdARrbi0eYd1SYRpXKwOjxSzNggooi/6JxEKPWKpk0U0CaD+aWxGWPhL3SCBnDcJoBBXsZWtzQAjPbpUhLYpH51kjviDRIZ3l5zsBLQ0pqwudemYXeI9sCkvwRGMn/qdgYHnM423krcw17njSVkvaAmYchU5Feo9a4tGU8YzRY+AOzKkwuDycpAlbk4/ijsIOKHEUOThjBopo33fXqFD3ktm/wSQPtXPFiPhWNSHxgjpfyEc2B3KI8tuOAdl+CLjQr5ITAV2OTlgHNZnAh0AuvaWpoV499/e5/pnyXfHhe8ysjO65YDAvNVpXQKCAQAWplxYIEhQcE51AqOXVwQNNNo6NHjBVNTkpcAtJC7gT5bmHkvQkEq9rI837rHgnzGC0jyQQ8tkL4gAQWDt+coJsyB2p5wypifyRz6Rh5uixOdEvSCBVEy1W4AsNo0fqD7UielOD6BojjJCilx4xHjGjQUntxyaOrsLC+EsRGiWOefTznTbEBplqiuH9kxoJts+xy9LVZmDS7TtsC98kOmkltOlXVNb6/xF1PYZ9j897buHOSXC8iTgdzEpbaiH7B5HSPh++1/et1SEMWsiMt7lU92vAhErDR8C2jCXMiT+J67ai51LKSLZuovjntnhA6Y8UoELxoi34u1DFuHvF9veA4IBBgACggEBAIdqogluJSr/oujPSLYjJN4s8QwFj2CU/4u5sYGgX17nqTt+mV0Fmh1Jvp4Xxj8RhyYnmIGy2oWpjXYJ9K0qvJlqkNdGiximOEv2zHbjDWBls3YSpZiLsIeD0KsyA6aXOLGeKlmE9zsAU6DkkSYGAiCguHrlcYdX6Zy1zEvTuvHJvotyIea6I8TVKG21bXtjLxdtpMe7t9STmBGaJJvwthTNvk4WVW7n0e8b0e4qEnILf1RNtNCqt3iZM7EdECgayTJKfgEojM4Ki8NKJf8OYDQV1nxptazl2o6aRHhjVVnImf/hlZFLvD7d507l4T8R4TGZAKA3oWcmg4yueEpqCUc=";

        System.out.println(new KeyDAO().getPublicKey("1101", "2023-12-14 14:42:14"));
    }
}
