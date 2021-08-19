package kr.co.utils;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.MediaType;

public class Utils_test {

	public static String rename(String oriName) {
		String newName = null;

		UUID uid = UUID.randomUUID();
		newName = uid.toString() + "_" + oriName;

		return newName;
	}

	public static String makeDir(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int date = cal.get(Calendar.DATE);

		File f_year = new File(uploadPath, year + "");
		File f_month = new File(f_year, month < 10 ? "0" + month : "" + month);
		File f_date = new File(f_month, date < 10 ? "0" + date : "" + date);

		if (!f_year.exists()) {
			f_year.mkdir();
		}

		if (!f_month.exists()) {
			f_month.mkdir();
		}

		if (!f_date.exists()) {
			f_date.mkdir();
		}

		return f_date.getAbsolutePath();
	}

	public static String getPathfileName(String aPath, String newName) {
		int idx = aPath.indexOf("uploads") + "uploads".length();
		String pathFileName = aPath.substring(idx) + File.separator + newName;

		return pathFileName;
	}

	public static String getExtendName(String oriName) {
		int idx = oriName.lastIndexOf(".");
		return oriName.substring(idx + 1);
	}

	public MediaType getMediaType(String extendName) {
		Map<String, MediaType> map = new HashMap<String, MediaType>();
		map.put("JPG", MediaType.IMAGE_JPEG);
		return null;
	}
}
