package cn.edu.hebtu.www.clubassembly.web.service;

import cn.edu.hebtu.www.clubassembly.web.model.City;
import cn.edu.hebtu.www.clubassembly.web.model.Province;
import cn.edu.hebtu.www.clubassembly.web.model.School;
import cn.edu.hebtu.www.clubassembly.web.model.Student;

import java.util.List;

/**
 * Created by Administrator on 15-3-21.
 */
public interface SchoolServiceI {

    public List<School> getAllSchool();

    public List<Province> getAllProvince();

    public List<City> getCities(String province);

    public List<City> getCitiesByID(int provinceid);

    public List<School> getSchools(String city);

    public List<School> getSchoolsByID(int cityid);

    public School getSchoolBySchoolName(String schoolName);

    public City getCityByCityName(String cityName);

    public Province getProvinceByProvinceName(String provinceName);


    public School getSchoolBySchoolID(int schoolID);

    public City getCityByCityID(int cityID);

    public Province getProvinceByProvinceID(int provinceID);
}
