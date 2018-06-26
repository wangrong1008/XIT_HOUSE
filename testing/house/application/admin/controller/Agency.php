<?php

namespace app\admin\controller;

use think\Controller;
use app\admin\model\Admin as AdminModel;
use think\Db;

class Agency extends BaseController
{
    /**
     * 初始化判断是否有访问该控制器权限
     */
    public function _initialize()
    {
        //获取当前控制器名称
        $oath = strtolower(request()->controller());
        //开启session
        session_start();
        $oathArr = $_SESSION['oath'];
        if (!in_array($oath, $oathArr)) {
            exit('很抱歉，您没有该访问权限!');
        }
    }

    /**
     * 中介用户列表
     */
    public function index()
    {
        //创建admin的model实例
        $admin = new AdminModel;
        $bread = array(
            '0' => array(
                'name' => '用户管理',
                'url' => ''
            ),
            '1' => array(
                'name' => '中介用户列表',
                'url' => '/admin/agency/index'
            )
        );
        $this->assign('breadhtml', $this->getBread($bread));
        //搜索条件
        $where = array();
        $where['type'] = 1;  //1表示中介,2表示平台人员
        $username = input('get.username');
        if ($username) {
            $where['username'] = array('like', '%' . $username . '%');
            //定义username模板变量，传输到模板视图中
            $this->assign('username', $username);
        }
        //获取中介列表
        $list = $admin->getList($where);
        //定义list模板变量，传输到模板视图中
        $this->assign('list', $list);
        // 返回当前控制器对应的视图模板index.html
        echo $this->fetch();
    }

    /**
     * 中介编辑页面
     */
    public function set()
    {
        $id = input('get.id');
        $bread = array(
            '0' => array(
                'name' => '用户管理',
                'url' => ''
            ),
            '1' => array(
                'name' => '中介用户列表',
                'url' => '/admin/agency/index'
            ),
            '2' => array(
                'name' => '中介设置',
                'url' => '/admin/agency/set?id=' . $id
            )
        );
        $this->assign('breadhtml', $this->getBread($bread));
        //处理编辑界面
        if ($id) {
            //创建admin的model实例
            $admin = new AdminModel;
            //获取中介用户信息
            $data = $admin->findById($id);
            //定义data的模板变量，传输到模板视图中
            $this->assign('data', $data);
        }
        // 返回当前控制器对应的视图模板index.html
        echo $this->fetch();
    }

    /**
     * 添加和编辑的保存
     */
    public function save()
    {
        //创建admin的model实例
        $admin = new AdminModel;
        $id = input('post.id');
        $data = input('post.');
        if (request()->isPost()) {

            $data = input('post.');
            if ($data['password'] == '') {
                unset($data['password']);
            } else {
                $data['password'] = sha256($data['password']);
            }
            if ($id) {  //编辑的保存
                $where = array('id' => $id);
                // 获取表单上传文件 例如上传了001.jpg
                $file = request()->file('user_img');

                // 移动到框架应用根目录/public/uploads/ 目录下
                if ($file) {
                    $info = $file->move(ROOT_PATH . 'public' . DS . 'upload');
                    if ($info) {
                        // 成功上传后 获取上传信息;
                        // 输出 20171224/42a79759f284b767dfcb2a0197904287.jpg
                        $data['user_img'] = $info->getSaveName();
                    } else {
                        // 上传失败获取错误信息
                        ajaxReturn('', '图片上传失败', 1);
                    }
                }
                $re = $admin->updateData($data, $where);
                if ($re !== FALSE) {
                    ajaxReturn('', '保存成功', 1);
                } else {
                    ajaxReturn('', '保存失败', 1);
                }
            }
        }
    }

    /**
     * 通过主键id删除数据
     */
    public function delete()
    {
        $id = input('post.id');
        //创建admin的model实例
        $agency = new AdminModel;
        //通过主键id删除数据
        $re = $agency->deleteById($id);
        if ($re) {
            ajaxReturn('', '删除成功', 1);
        } else {
            ajaxReturn('', '删除失败', 0);
        }
    }

    /**
     * 通过主键id更新status状态
     */
    public function updateStatus()
    {
        $id = input('post.id');
        $status = input('post.status');
        $agency = new AdminModel;
        $data = ['status' => $status];
        $where = ['id' => $id];
        $re = $agency->updateData($data, $where);

        //搜索条件
        $where = array();
        $where['type'] = 1;  //1表示中介,2表示房东
        $username = input('get.username');
        if ($username) {
            $where['username'] = array('like', '%' . $username . '%');
            $this->assign('username', $username);
        }
        $list = $agency->getList($where);

        $this->assign('list', $list);
        if ($re !== FALSE) {
            ajaxReturn($this->fetch('ajaxPage'), '更新成功', 1);
        } else {
            ajaxReturn('', '更新失败', 0);
        }
    }

    //刷新页面
    public function refresh()
    {
        //搜索条件
        $where = array();
        $where['type'] = 1;  //1表示中介,2表示房东
        $username = input('get.username');
        if ($username) {
            $where['username'] = array('like', '%' . $username . '%');
            $this->assign('username', $username);
        }
        $agency = new AdminModel;
        $list = $agency->getList($where);

        $this->assign('list', $list);
        ajaxReturn($this->fetch('ajaxPage'), '刷新成功', 1);
    }

    public function test()
    {
        $list = Db::name('admin')->select();
        return $list[0];
    }

    public function test1()
    {
        var_dump($this->test());
    }


}
