package edu.epam.fop.rest;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class DispatcherServletInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return null; // No root configuration for this simple app
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] { WebConfig.class }; // Reference to our WebConfig
    }

    @Override
    protected String[] getServletMappings() {
        return new String[] { "/" }; // Map DispatcherServlet to root path
    }
}