package com.mmall.service;

import org.springframework.stereotype.Service;

import java.io.File;

@Service
public class ResourceService {
	public File findFile(String url){
		return new File(url);
	}
}
