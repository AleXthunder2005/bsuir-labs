package edu.epam.fop;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class MyAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

  protected Class<?>[] getRootConfigClasses() {
    return new Class<?>[] {};
  }

  @Override
  protected Class<?>[] getServletConfigClasses() {
    return new Class<?>[] {WebConfig.class};
  }

  @Override
  protected String[] getServletMappings() {
    return new String[] {"/"};
  }

}
