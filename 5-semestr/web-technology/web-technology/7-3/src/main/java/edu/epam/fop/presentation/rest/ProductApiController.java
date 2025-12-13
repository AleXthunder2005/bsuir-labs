package edu.epam.fop.presentation.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import edu.epam.fop.presentation.rest.api.Product;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

@RestController
@RequestMapping("/api/products")
public class ProductApiController {

    @Operation(summary = "Get product by ID", description = "Retrieves a product with the specified ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Product found",
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(implementation = Product.class))),
            @ApiResponse(responseCode = "404", description = "Product not found")
    })
    @GetMapping("/{id}")
    public Product getProduct(
            @Parameter(description = "Product ID", required = true) @PathVariable long id) {
        // Return a dummy product based on the id
        return new Product(id, "Product " + id);
    }

}
