package kr.co.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class Utils {

	// rename files name
	public static String rename(String oriName) {
		String newName = null;

		UUID uid = UUID.randomUUID();
		newName = uid.toString() + "_" + oriName;

		return newName;
	}

	// make folder directory by year/month/date
	public static String makeDir(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);

		File yearDir = new File(uploadPath, year + "");

		if (!yearDir.exists()) {
			yearDir.mkdir();
		}

		int month = cal.get(Calendar.MONTH) + 1;
		File monthDir = new File(yearDir, month < 10 ? "0" + month : "" + month);
		if (!monthDir.exists()) {
			monthDir.mkdir();
		}

		int date = cal.get(Calendar.DATE);
		File dateDir = new File(monthDir, date < 10 ? "0" + date : "" + date);
		if (!dateDir.exists()) {
			dateDir.mkdir();
		}
		return dateDir.getAbsolutePath();
	}
	
	// get files extend name
	public static String getExtendName(String oriName) {
		int idx = oriName.lastIndexOf(".");

		return oriName.substring(idx + 1);
	}

	// check image type
	public static MediaType getMediaType(String extendName) {
		Map<String, MediaType> map = new HashMap<String, MediaType>();
		map.put("JPG", MediaType.IMAGE_JPEG);
		map.put("JPEG", MediaType.IMAGE_JPEG);
		map.put("PNG", MediaType.IMAGE_PNG);
		map.put("GIF", MediaType.IMAGE_GIF);

		return map.get(extendName.toUpperCase());
	}

	// get files ori name
	public static String getPathFileName(String aPath, String newName) {

		int idx = aPath.indexOf("uploads") + "uploads".length();

		String pathFileName = aPath.substring(idx) + File.separator + newName;
		pathFileName = pathFileName.replace(File.separatorChar, '/');

		return pathFileName;
	}

	// upload files
	public static String uploadFile(String oriName, String uploadPath, MultipartFile file) throws Exception {
		String path = Utils.makeDir(uploadPath);
		String newName = Utils.rename(oriName);

		File target = new File(path, newName);
		FileCopyUtils.copy(file.getBytes(), target);

		
		return Utils.getPathFileName(path, newName);
//		if (mType != null) {
//			return Utils.makeThumbnamil(path, newName);
//		} else {
//			return Utils.getPathFileName(path, newName);
//		}
	}

	//make thumbnail image
	public static String makeThumbnamil(String aPath, String newName) throws Exception {
		int idx = newName.indexOf("_");
		String thumbnailName = newName.substring(0, idx) + "_s" + newName.substring(idx);

		BufferedImage sourceImg = ImageIO.read(new File(aPath, newName));
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_EXACT, 100);
		File f = new File(aPath, thumbnailName);

		String extendName = Utils.getExtendName(newName).toUpperCase();

		ImageIO.write(destImg, extendName, f);

		return getPathFileName(aPath, thumbnailName);
	}

	public static String getSystemFileName(String filename) {
		String name = null;
		int idx = filename.indexOf("_");
		String prefix = filename.substring(0, idx);
		String suffix = filename.substring(idx+1);
		
		name = prefix + suffix;
		
		return name;
		
	}
}
