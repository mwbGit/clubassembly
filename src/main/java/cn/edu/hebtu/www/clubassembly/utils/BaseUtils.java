package cn.edu.hebtu.www.clubassembly.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.log4j.Logger;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by Administrator on 15-3-21.
 */
public class BaseUtils {
    public static final Gson gson = new GsonBuilder().setDateFormat(Constant.DATE_TYPE).excludeFieldsWithoutExposeAnnotation().create();
    private static Logger logger = Logger.getLogger(BaseUtils.class);

    /**
     * 将字符串型日期转换成日期型数据。
     */
    public static Date StringToDate(String dateStr) {
        DateFormat dd = new SimpleDateFormat(Constant.DATE_TYPE);
        Date date = null;
        try {
            logger.info("string to date:" + dateStr);
            date = dd.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }


    /**
     * 将字符串型日期转换成日期型数据。
     */
    public static Date StringToDateNoSecond(String dateStr) {
        DateFormat dd = new SimpleDateFormat(Constant.DATE_TYPE2);
        Date date = null;
        try {
            logger.info("string to date:" + dateStr);
            date = dd.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }


    public static String DateToString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat(Constant.DATE_TYPE);
        logger.info("date to string:" + sdf.format(date));
        return sdf.format(date);
    }

    /**
     * 日期型数据加减法。
     *
     * @param specifiedDay
     * @param length
     * @return
     */
    public static String getSpecifiedDay(String specifiedDay, int length) {
        //可以用new Date().toLocalString()传递参数
        Calendar c = Calendar.getInstance();
        Date date = null;
        try {
            date = new SimpleDateFormat(Constant.DATE_TYPE).parse(specifiedDay);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        c.setTime(date);
        int day = c.get(Calendar.DATE);
        c.set(Calendar.DATE, day + length);
        String dayBefore = new SimpleDateFormat(Constant.DATE_TYPE).format(c.getTime());
        return dayBefore;
    }
}
