package xyz.xqsr.staticMethod;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import aj.org.objectweb.asm.Type;
import javassist.compiler.ast.NewExpr;

public class StaticLog {

	//写入日志文件
	public static void insertLog(String username,String log) {

		FileWriter fw = null;
		try {
		//如果文件存在，则追加内容；如果文件不存在，则创建文件
			File f=new File("E://"+username+".txt");
			fw = new FileWriter(f, true);
		} catch (IOException e) {
			e.printStackTrace();
		}
		PrintWriter pw = new PrintWriter(fw);
		pw.println(log);
		pw.flush();
		try {
			fw.flush();
			pw.close();
			fw.close();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		
	}	
	
	//读取日志文件

	public static List<Object> readFile1(String username) throws IOException {
		File fin = new File("E://"+username+".txt");
		FileInputStream fis = new FileInputStream(fin);
	 
		//Construct BufferedReader from InputStreamReader
		BufferedReader br = new BufferedReader(new InputStreamReader(fis));
	 
		String line = null;
		ArrayList<Object> list2 = new ArrayList<Object>();
		while ((line = br.readLine()) != null) {
			ArrayList<String> list = new ArrayList<String>();
			list.add(line.split(",")[0]);
			list.add(line.split(",")[1]);
			list2.add(list);
		}
		br.close();
	    fis.close();
	    return list2;
	}
	//获取当前时间
	public static String nowTime() { 
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        return df.format(new Date());// new Date()为获取当前系统时间
  }
}

