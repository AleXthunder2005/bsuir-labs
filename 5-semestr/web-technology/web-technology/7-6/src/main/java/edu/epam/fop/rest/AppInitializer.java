package edu.epam.fop.rest;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class AppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[] { SecurityConfig.class }; // Security config as root
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] { WebConfig.class }; // MVC config as servlet
    }

    @Override
    protected String[] getServletMappings() {
        return new String[] { "/" };
    }
}