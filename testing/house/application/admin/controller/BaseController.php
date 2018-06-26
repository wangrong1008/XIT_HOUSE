<?php


namespace app\admin\controller;


use think\Controller;
use app\admin\model\AdminOath as AdminOathModel;

class BaseController extends Controller
{
    /**
     * 后台控制器初始化
     */
    public function _initialize()
    {
        $status = self::isLogin();
        if (!$status) { //还没登录，跳转到登录页面
            $this->redirect('Login/index');
        }
        //权限处理
        $type = $_SESSION['think']['admin']['type'];
        $adminOath = new AdminOathModel;
        $admin_oath = $adminOath->where(['type' => $type])->select();
        $oath = array();
        foreach ($admin_oath as $v) {
            $oath[] = strtolower($v->controller);
        }
        $_SESSION['oath'] = $oath;
        $_SESSION['oath_str'] = implode(',', $oath);

    }

    /**
     * 检查用户是否登录
     * @return bool|mixed
     */
    public function isLogin()
    {
        $admin = session('admin');
        if (empty($admin)) {
            return false;
        } else {
            return session('admin_sign') == dataAuthSign($admin) ? $admin["id"] : false;
        }
    }

    /**
     * 用户登出
     */

    public function logout()
    {
        session('admin', NULL);
        session('admin_sign', NULL);
        $this->redirect('Login/index');
    }

    /**
     * 发送email
     * @param $toemail array|string 要发送到的email地址
     * @param $subject string  email标题
     * @param $body string  email主体内容
     * @return bool
     */
    function send_email($toemail, $subject, $body)
    {

        $mail = new \app\common\PHPMailer\PHPMailer();

        $mail->SMTPDebug = 0;

        $mail->isSMTP();
        //加密方式 "ssl" or "tls"
        $mail->SMTPSecure = config('email_config.secure');
        //smtp需要鉴权
        $mail->SMTPAuth = true;
        $mail->Host = config('email_config.host');
        $mail->Port = config('email_config.port');
        $mail->Username = config('email_config.username');
        $mail->Password = config('email_config.psw');

        $mail->From = config('email_config.From');
        $mail->FromName = config('email_config.FromName');
        $mail->CharSet = 'UTF-8';
        $mail->isHTML(true);

        if (is_array($toemail)) {
            foreach ($toemail as $to_email) {
                $mail->AddAddress($to_email);
            }
        } else {
            $mail->AddAddress($toemail);
        }
        //添加该邮件的主题
        $mail->Subject = $subject;
        //添加邮件正文
        $mail->Body = $body;
        //为该邮件添加附件 该方法也有两个参数 第一个参数为附件存放的目录（相对目录、或绝对目录均可） 第二参数为在邮件附件中该附件的名称
        //$mail->addAttachment('./d.jpg','mm.jpg');
        //同样该方法可以多次调用 上传多个附件
        //$mail->addAttachment('./Jlib-1.1.0.js','Jlib.js');
        //dump($mail);exit;

        $status = $mail->send();

        if ($status) {
            return true;
        } else {
            return false;
        }
    }

    //拼装面包导航
    public function getBread($bread)
    {
        if ($bread) {
            $this->assign('bread', $bread);
            return $this->fetch('base/bread');
        } else {
            $this->error('请传入面包导航！');
        }
    }

}