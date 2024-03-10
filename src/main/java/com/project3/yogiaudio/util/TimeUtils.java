package com.project3.yogiaudio.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class TimeUtils {


	public static String timestampToString(Timestamp timestamp) {
		// yyyy-MM-dd HH:mm:ss
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(timestamp);
	}

}
