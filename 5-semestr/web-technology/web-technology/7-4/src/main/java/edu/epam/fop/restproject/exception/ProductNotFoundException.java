package edu.epam.fop.restproject.exception;

public class ProductNotFoundException extends RuntimeException {

    private final Long productId;

    public ProductNotFoundException(Long productId) {
        super("Product with ID " + productId + " not found");
        this.productId = productId;
    }

    public ProductNotFoundException(Long productId, String message) {
        super(message);
        this.productId = productId;
    }

    public Long getProductId() {
        return productId;
    }
}