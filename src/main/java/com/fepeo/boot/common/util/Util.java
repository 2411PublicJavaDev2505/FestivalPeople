package com.fepeo.boot.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Util {

	public static int seqNum = 1;
	
	public static String fileRename(String originalFileName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new Date(System.currentTimeMillis()));
		String str = "_" + String.format("%05d", seqNum++);
		String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
		return date + str + ext;
	}
}
