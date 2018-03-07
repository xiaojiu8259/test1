package com.eccl;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 * @author niujunlong
 */
public class Config  {
	  /** Logger for this class. */
	private final Logger logger = Logger.getLogger(getClass());
	
	private Properties props =null;

	private static class LazyHolder {
		private static final Config instance = new Config();
	}
	
	private Config() { init(); }
	/**
	 * 单线程单例模式
	 * @return 返回 Config实例对象
	 */
	public static final Config getSingleton() {
        return LazyHolder.instance;
    }
	
	public Properties getProps() {
		return props;
	}
	
	public String getStringValue(String key) {
		if(key!=null&&!"".equals(key.trim())) {
			key = key.trim();
			if(props==null){
				loadProperties();
			}
			if(!props.containsKey(key)) {
				logger.warn("参数 ["+key+"] 不存在!");
			} else {
				return (String)props.get(key);
			}
		}
		return "";
	}
	
	public int getIntValue(String key) {
		int returnValue = 0;
		String value = this.getStringValue(key);
		if(value!=null&&!"".equals(value)) {
			try {
				returnValue =Integer.parseInt(value);
			} catch (NumberFormatException e) {
				logger.warn("参数 ["+key+"=="+value+"] 无法转换为整数类型!");
			}
		}
		return returnValue;
	}

	private void loadProperties(){
		try {
			props=new Properties();
			props.load(getClass().getResourceAsStream("/dbconf.properties"));
		} catch (FileNotFoundException e) {
			logger.error(e.getMessage(),e);
			
		} catch (IOException e) {
			logger.error(e.getMessage(),e);
		}
	}

	private void init(){
		if(props==null){
			loadProperties();
		}
	}
}
