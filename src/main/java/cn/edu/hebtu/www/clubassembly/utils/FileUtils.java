package cn.edu.hebtu.www.clubassembly.utils;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.*;
import java.util.StringTokenizer;

@Component
public class FileUtils {
    private static Logger logger = Logger.getLogger(FileUtils.class);
    private String message;

    public static boolean saveImage(String savePath, String filename, CommonsMultipartFile commonsMultipartFile) {
        logger.info("----------save image begin--------------------------");
        logger.info("OriginalFilename:" + commonsMultipartFile.getOriginalFilename());
        logger.info("ContentType:" + commonsMultipartFile.getContentType());
        logger.info("name:" + commonsMultipartFile.getName());
        logger.info("Size:" + commonsMultipartFile.getSize());
        FileItem item = commonsMultipartFile.getFileItem();
        long fileSize = item.getSize();
        String fileName = item.getName();
        logger.info("FieldName:" + item.getFieldName());
        logger.info("savepath:" + savePath);
        logger.info("filename:" + fileName);
        logger.info("filesize:" + fileSize);
        if (!item.isFormField()) {
            try {
                File uploadedFile = new File(savePath, filename);
                item.write(uploadedFile);
                logger.info(filename + "上传文件成功");
                return true;
            } catch (Exception e) {
                logger.info(filename + "上传文件失败");
            }
        }
        return false;
    }


    /**
     * 遍历文件夹中文件
     *
     * @param filepath
     * @return 返回file［］数组
     */
    public File[] getFileList(String filepath) {
        File d = null;
        File list[] = null;
        // 建立当前目录中文件的File对象
        try {
            d = new File(filepath);
            if (d.exists()) {
                list = d.listFiles();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            message = "遍历文件夹出错";
        }
        // 取得代表目录中所有文件的File对象数组
        return list;
    }

    /**
     * 读取文本文件内容
     *
     * @param filePathAndName 带有完整绝对路径的文件名
     * @param encoding        文本文件打开的编码方式
     * @return 返回文本文件的内容
     */
    public String readTxt(String filePathAndName, String encoding) throws IOException {
        encoding = encoding.trim();
        StringBuffer str = new StringBuffer("");
        String st = "";
        try {
            FileInputStream fs = new FileInputStream(filePathAndName);
            InputStreamReader isr;
            if (encoding.equals("")) {
                isr = new InputStreamReader(fs);
            } else {
                isr = new InputStreamReader(fs, encoding);
            }
            BufferedReader br = new BufferedReader(isr);
            try {
                String data = "";
                while ((data = br.readLine()) != null) {
                    str.append(data);
                }
            } catch (Exception e) {
                str.append(e.toString());
            }
            st = str.toString();
            if (st != null && st.length() > 1)
                st = st.substring(0, st.length() - 1);
        } catch (IOException es) {
            st = "";
        }
        return st;
    }

    /**
     * 新建目录
     *
     * @param folderPath 目录
     * @return 返回目录创建后的路径
     */
    public String createFolder(String folderPath) {
        String txt = folderPath;
        try {
            File myFilePath = new File(txt);
            txt = folderPath;
            if (!myFilePath.exists()) {
                myFilePath.mkdir();
            }
        } catch (Exception e) {
            message = "创建目录操作出错";
        }
        return txt;
    }

    /**
     * 多级目录创建
     *
     * @param folderPath 准备要在本级目录下创建新目录的目录路径例如 c:myf
     * @param paths      无限级目录参数，各级目录以单数线区分 例如 a|b|c
     * @return 返回创建文件后的路径
     */
    public String createFolders(String folderPath, String paths) {
        String txts = folderPath;
        try {
            String txt;
            txts = folderPath;
            StringTokenizer st = new StringTokenizer(paths, "|");
            for (int i = 0; st.hasMoreTokens(); i++) {
                txt = st.nextToken().trim();
                if (txts.lastIndexOf("/") != -1) {
                    txts = createFolder(txts + txt);
                } else {
                    txts = createFolder(txts + txt + "/");
                }
            }
        } catch (Exception e) {
            message = "创建目录操作出错";
        }
        return txts;
    }

    /**
     * 新建文件
     *
     * @param filePathAndName 文本文件完整绝对路径及文件名
     * @param fileContent     文本文件内容
     * @return
     */
    public void createFile(String filePathAndName, String fileContent) {
        try {
            String filePath = filePathAndName;
            filePath = filePath.toString();
            File myFilePath = new File(filePath);
            if (!myFilePath.exists()) {
                myFilePath.createNewFile();
            }
            FileWriter resultFile = new FileWriter(myFilePath);
            PrintWriter myFile = new PrintWriter(resultFile);
            String strContent = fileContent;
            myFile.println(strContent);
            myFile.close();
            resultFile.close();
        } catch (Exception e) {
            message = "创建文件操作出错";
        }
    }

    /**
     * 有编码方式的文件创建
     *
     * @param filePathAndName 文本文件完整绝对路径及文件名
     * @param fileContent     文本文件内容
     * @param encoding        编码方式 例如 GBK 或者 UTF-8
     * @return
     */
    public void createFile(String filePathAndName, String fileContent, String encoding) {
        try {
            String filePath = filePathAndName;
            filePath = filePath.toString();
            File myFilePath = new File(filePath);
            if (!myFilePath.exists()) {
                myFilePath.createNewFile();
            }
            PrintWriter myFile = new PrintWriter(myFilePath, encoding);
            String strContent = fileContent;
            myFile.println(strContent);
            myFile.close();
        } catch (Exception e) {
            message = "创建文件操作出错";
        }
    }

    /**
     * 删除文件
     *
     * @param filePathAndName 文本文件完整绝对路径及文件名
     * @return Boolean 成功删除返回true遭遇异常返回false
     */
    public boolean delFile(String filePathAndName) {
        boolean bea = false;
        try {
            String filePath = filePathAndName;
            File myDelFile = new File(filePath);
            if (myDelFile.exists()) {
                myDelFile.delete();
                bea = true;
            } else {
                bea = false;
                message = (filePathAndName + "删除文件操作出错");
            }
        } catch (Exception e) {
            message = e.toString();
        }
        return bea;
    }

    /**
     * 删除文件
     *
     * @param folderPath 文件夹完整绝对路径
     * @return
     */
    public void delFolder(String folderPath) {
        try {
            delAllFile(folderPath); // 删除完里面所有内容
            String filePath = folderPath;
            filePath = filePath.toString();
            File myFilePath = new File(filePath);
            myFilePath.delete(); // 删除空文件夹
        } catch (Exception e) {
            message = ("删除文件夹操作出错");
        }
    }

    /**
     * 删除指定文件夹下所有文件
     *
     * @param path 文件夹完整绝对路径
     * @return
     */
    public boolean delAllFile(String path) {
        boolean bea = false;
        File file = new File(path);
        if (!file.exists()) {
            return bea;
        }
        if (!file.isDirectory()) {
            return bea;
        }
        String[] tempList = file.list();
        File temp = null;
        for (int i = 0; i < tempList.length; i++) {
            if (path.endsWith(File.separator)) {
                temp = new File(path + tempList[i]);
            } else {
                temp = new File(path + File.separator + tempList[i]);
            }
            if (temp.isFile()) {
                temp.delete();
            }
            if (temp.isDirectory()) {
                delAllFile(path + "/" + tempList[i]);// 先删除文件夹里面的文件
                delFolder(path + "/" + tempList[i]);// 再删除空文件
                bea = true;
            }
        }
        return bea;
    }

    /**
     * 复制单个文件
     *
     * @param oldPathFile 准备复制的文件源
     * @param newPathFile 拷贝到新绝对路径带文件名
     * @return
     */
    public void copyFile(String oldPathFile, String newPathFile) {
        try {
            int bytesum = 0;
            int byteread = 0;
            File oldfile = new File(oldPathFile);
            if (oldfile.exists()) { // 文件存在
                InputStream inStream = new FileInputStream(oldPathFile); // 读入源文件
                FileOutputStream fs = new FileOutputStream(newPathFile);
                byte[] buffer = new byte[1444];
                while ((byteread = inStream.read(buffer)) != -1) {
                    bytesum += byteread; // 字节 文件大小
                    System.out.println(bytesum);
                    fs.write(buffer, 0, byteread);
                }
                inStream.close();
            }
        } catch (Exception e) {
            message = ("复制单个文件操作出错");
        }
    }

    /**
     * 复制整个文件夹的内容
     *
     * @param oldPath 准备拷贝的目录
     * @param newPath 指定绝对路径的新目录
     * @return
     */
    public void copyFolder(String oldPath, String newPath) {
        try {
            new File(newPath).mkdirs(); // 如果文件夹不存在 则建立新文件
            File a = new File(oldPath);
            String[] file = a.list();
            File temp = null;
            for (int i = 0; i < file.length; i++) {
                if (oldPath.endsWith(File.separator)) {
                    temp = new File(oldPath + file[i]);
                } else {
                    temp = new File(oldPath + File.separator + file[i]);
                }
                if (temp.isFile()) {
                    FileInputStream input = new FileInputStream(temp);
                    FileOutputStream output = new FileOutputStream(newPath
                            + "/" + (temp.getName()).toString());
                    byte[] b = new byte[1024 * 5];
                    int len;
                    while ((len = input.read(b)) != -1) {
                        output.write(b, 0, len);
                    }
                    output.flush();
                    output.close();
                    input.close();
                }
                if (temp.isDirectory()) {// 如果是子文件
                    copyFolder(oldPath + "/" + file[i], newPath + "/" + file[i]);
                }
            }
        } catch (Exception e) {
            message = "复制整个文件夹内容操作出错";
        }
    }

    /**
     * 移动文件
     *
     * @param oldPath
     * @param newPath
     * @return
     */
    public void moveFile(String oldPath, String newPath) {
        copyFile(oldPath, newPath);
        delFile(oldPath);
    }

    /**
     * 移动目录
     *
     * @param oldPath
     * @param newPath
     * @return
     */
    public void moveFolder(String oldPath, String newPath) {
        copyFolder(oldPath, newPath);
        delFolder(oldPath);
    }

    /**
     * 建立一个可以追加的bufferedwriter
     *
     * @param fileDir
     * @param fileName
     * @return
     */
    public BufferedWriter getWriter(String fileDir, String fileName) {
        try {
            File f1 = new File(fileDir);
            if (!f1.exists()) {
                f1.mkdirs();
            }
            f1 = new File(fileDir, fileName);
            if (!f1.exists()) {
                f1.createNewFile();
            }
            BufferedWriter bw = new BufferedWriter(new FileWriter(f1.getPath(),
                    true));
            return bw;
        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
            return null;
        }
    }

    /**
     * 得到一个bufferedreader
     *
     * @param fileDir
     * @param fileName
     * @param encoding
     * @return
     */
    public BufferedReader getReader(String fileDir, String fileName,
                                    String encoding) {
        try {
            File file = new File(fileDir, fileName);
            InputStreamReader read = new InputStreamReader(new FileInputStream(
                    file), encoding);
            BufferedReader br = new BufferedReader(read);
            return br;

        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
            return null;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

    }

    public String getMessage() {
        return this.message;
    }


    //递归打印一个目录。
//    private List<MyFile> myFileList = new ArrayList<MyFile>();
//    public void begin() {
//        File file = new File("C:\\Users\\Administrator\\AppData\\Local\\apache-tomcat-7.0.53\\webapps\\ecampus");
//        getFile(file);
//        System.out.print(myFileList.size());
//
//        //带缩进的打印文件列表
//        for (Iterator<MyFile> iter = myFileList.iterator(); iter.hasNext(); ) {
//            MyFile myfile = iter.next();
//            System.out.println("所属依赖：" + myfile.getDI());
//            System.out.println("文件名：" + myfile.getName());
//            System.out.println("文件类型" + myfile.getType());
//            System.out.println("------------------------------------------");
//        }
//
//        TreeNode<MyFile> filetree = new TreeNode<MyFile>();
//        //建立根结点。
//        MyFile myFile = new MyFile();
//        myFile.setDI("null");
//        myFile.setName("ecampus");
//        myFile.setType("directory");
//        filetree.setT(myFile);
//
//        //带缩进的打印文件列表
//        for (Iterator<MyFile> iter = myFileList.iterator(); iter.hasNext(); ) {
//
//
//            MyFile myfile = iter.next();
//            filetree.setT(myfile);
//            filetree.setId(UUID.randomUUID().toString());
//
//        }
//    }
//
//    /**
//     * 递归遍历目录
//     */
//    private void getFile(File file) {
//        if (file.isDirectory() && file.getName().equals("ecampus")) {
//            //根目录
//            String root = file.getName();
//            //得到根目录下的所有目录
//            File[] filelist = file.listFiles();
//            if (filelist.length > 0) {
//                for (int i = 0; i < filelist.length; i++) {
//                    File afile = filelist[i];
//                    //此时myfile可能是文件，也可能是目录
//
//                    MyFile myfile = new MyFile();
//                    myfile.setDI(root);
//                    myfile.setName(afile.getName());
//                    if (afile.isFile()) {
//                        myfile.setType("file");
//                        myFileList.add(myfile);
//                    } else if (afile.isDirectory()) {
//                        myfile.setType("directory");
//                        myFileList.add(myfile);
//                        getFile(afile);
//                    }
//
//                }
//            }
//
//        } else if (file.isDirectory()) {
//            File[] filelist = file.listFiles();
//            if (filelist.length > 0) {
//                for (int i = 0; i < filelist.length; i++) {
//                    File afile = filelist[i];
//                    //此时myfile可能是文件，也可能是目录
//
//                    MyFile myfile = new MyFile();
//                    //依赖
//                    myfile.setDI(file.getName());
//                    //文件名
//                    myfile.setName(afile.getName());
//                    if (afile.isFile()) {
//                        myfile.setType("file");
//                        myFileList.add(myfile);
//                    } else if (afile.isDirectory()) {
//                        myfile.setType("directory");
//                        myFileList.add(myfile);
//                        getFile(afile);
//                    }
//
//                }
//            }
//        } else if (file.isFile()) {
//
//        }
//    }
}
