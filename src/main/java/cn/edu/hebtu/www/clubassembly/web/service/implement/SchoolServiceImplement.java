package cn.edu.hebtu.www.clubassembly.web.service.implement;

import cn.edu.hebtu.www.clubassembly.common.dao.BaseDaoI;
import cn.edu.hebtu.www.clubassembly.web.model.City;
import cn.edu.hebtu.www.clubassembly.web.model.Province;
import cn.edu.hebtu.www.clubassembly.web.model.School;
import cn.edu.hebtu.www.clubassembly.web.service.SchoolServiceI;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 15-3-21.
 */
@Service
public class SchoolServiceImplement implements SchoolServiceI {
    @Resource
    private BaseDaoI<School> schoolDao;
    @Resource
    private BaseDaoI<Province> provinceDao;
    @Resource
    private BaseDaoI<City> cityDao;

    @Override
    public List<School> getAllSchool() {
        String hql = "from School t ";
        return schoolDao.find(hql);
    }

    @Override
    public List<Province> getAllProvince() {
        String hql = "from Province t";
        return provinceDao.find(hql);
    }

    @Override
    public List<City> getCities(String province) {
        String hql = "from Province t where t.pr_province = :province";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("province", province);
        Province province1 = provinceDao.get(hql, params);
        if (province1 != null) {
            hql = "from City t where t.province = :province1";
            params.clear();
            params.put("province1", province1);
            return cityDao.find(hql, params);
        } else {
            return null;
        }
    }

    @Override
    public List<City> getCitiesByID(int provinceid) {
        String hql = "from Province t where t.pr_id = :provinceid";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("provinceid", provinceid);
        Province province1 = provinceDao.get(hql, params);
        if (province1 != null) {
            hql = "from City t where t.province = :province1";
            params.clear();
            params.put("province1", province1);
            return cityDao.find(hql, params);
        } else {
            return null;
        }
    }

    @Override
    public List<School> getSchools(String city) {
        String hql = "from City t where t.ci_city = :city";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("city", city);
        City city1 = cityDao.get(hql, params);
        if (city1 != null) {
            hql = "from School t where t.city = :city1";
            params.clear();
            params.put("city1", city1);
            return schoolDao.find(hql, params);
        } else {
            return null;
        }
    }


    @Override
    public List<School> getSchoolsByID(int cityid) {
        String hql = "from City t where t.ci_id = :cityid";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("cityid", cityid);
        City city1 = cityDao.get(hql, params);
        if (city1 != null) {
            hql = "from School t where t.city = :city1";
            params.clear();
            params.put("city1", city1);
            return schoolDao.find(hql, params);
        } else {
            return null;
        }
    }

    @Override
    public Province getProvinceByProvinceName(String provinceName) {
        String hql = "from Province t where t.pr_province = :provinceName";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("provinceName", provinceName);
        return provinceDao.get(hql, params);
    }

    @Override
    public City getCityByCityName(String cityName) {
        String hql = "from City t where t.ci_city = :cityName";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("cityName", cityName);
        return cityDao.get(hql, params);
    }

    @Override
    public School getSchoolBySchoolName(String schoolName) {
        String hql = "from School t where t.sh_school = :schoolName";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("schoolName", schoolName);
        return schoolDao.get(hql, params);
    }

    @Override
    public School getSchoolBySchoolID(int schoolID) {
        String hql = "from School t where t.sh_id = :schoolID";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("schoolID", schoolID);
        return schoolDao.get(hql, params);
    }

    @Override
    public City getCityByCityID(int cityID) {
        String hql = "from City t where t.ci_id = :cityID";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("cityID", cityID);
        return cityDao.get(hql, params);
    }

    @Override
    public Province getProvinceByProvinceID(int provinceID) {
        String hql = "from Province t where t.pr_id = :provinceID";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("provinceID", provinceID);
        return provinceDao.get(hql, params);
    }
}