package vn.edu.hcmuaf.fit.filter;

public class EditProductResponse {
    private int reponseCode;
    private String message;

    public EditProductResponse(int reponseCode, String message) {
        this.reponseCode = reponseCode;
        this.message = message;
    }

    public int getReponseCode() {
        return reponseCode;
    }

    public void setReponseCode(int reponseCode) {
        this.reponseCode = reponseCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
