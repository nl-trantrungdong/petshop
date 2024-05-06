package vn.edu.hcmuaf.fit.filter;

public class CartResponse
{
    private int reponseCode;
    private String message;
    private long totalCartValue;

    public CartResponse(int reponseCode,String message, long totalCartValue) {
        this.reponseCode=reponseCode;
        this.message = message;
        this.totalCartValue = totalCartValue;
    }

    // Getters and setters
}

