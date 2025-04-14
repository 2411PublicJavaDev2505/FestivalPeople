package com.fepeo.boot.common.controller.util;

import java.io.*;
import java.util.*;

public class ApiKeyLoader {

    private static final Properties properties = new Properties();

    static {
        String basePath = System.getProperty("user.dir"); // 현재 실행 위치
        String filePath = basePath + File.separator + "apikey.txt";

        try (InputStream input = new FileInputStream(filePath)) {
            properties.load(input);
        } catch (IOException e) {
            System.err.println("API 키 파일을 읽을 수 없습니다: " + e.getMessage());
        }
    }

    public static String get(String key) {
        return properties.getProperty(key);
    }
}