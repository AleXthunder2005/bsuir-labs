package com.epam.edu.springbootappconfiguration;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("dev")
class ApplicationTests {

	@Autowired
	private MockMvc mockMvc;

	@Test
	void getEnvDetailsTest() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/envDetails"))
				.andExpect(MockMvcResultMatchers.status().isOk())
				.andExpect(MockMvcResultMatchers.content().string("Application Name: bookstore-app-dev"));
	}

}
