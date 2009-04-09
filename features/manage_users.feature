功能: 管理用户
  为了统一管理用户信息
  作为管理员
  可以新增、修改、删除用户
  
  场景: 用户登录
    假如 我已经以管理员cogentsoft身份登录
    那么 我应该能看到:欢迎您:cogentsoft

  场景: 查询用户
    假如 我已经以管理员cogentsoft身份登录
    而且 我在用户管理页面
    那么 我应该能看到:用户列表
    而且 我应该能看到:查询条件

  场景: 新增用户
    假如 我已经以管理员cogentsoft身份登录
    而且 我在用户新增页面
    当 我输入用户名为saberma
    而且 我输入姓名为马海波
    而且 我输入密码为666666
    而且 我选中男
    而且 我选择部门为劳动局
    而且 我输入职位为科员
    而且 我输入办公电话为26742222"
    而且 我输入手机为13688888888
    而且 我输入电子邮箱为zhangsan@zhangsan.com
    而且 "我输入备注为备注
    而且 我点击保存,返回列表
    那么 我应该能看到:新增用户成功

  场景: 编辑用户
    假如 我已经以管理员cogentsoft身份登录
    而且 我在用户管理页面
    而且 有以下数据:
      |用户名|姓名|
      |aaron|阿郎|
      |cogentsoft|高正|
      |disable|禁用|
      |quentin|清亭|
    当 我修改第4个用户的姓名为清廷
    那么 我将看到以下数据:
      |用户名|姓名|
      |aaron|阿郎|
      |cogentsoft|高正|
      |disable|禁用|
      |quentin|清廷|

  场景: 业务操作人员登录
    假如 我已经以用户aaron身份登录
    那么 我应该能看到:新增来电
    而且 我应该看不到:用户管理

  场景: 登录用户修改密码
    假如 我已经以管理员cogentsoft身份登录
    当 我触发链接修改密码
    那么 我应该能看到:新密码
    而且 我输入新密码为:111
    而且 我点击提 交
    那么 我应该能看到:\u5bc6\u7801\u4fee\u6539\u6210\u529f

  场景: 禁用用户
    假如 我已经以管理员cogentsoft身份登录
    而且 我在用户管理页面
    而且 有以下数据:
      |用户名|姓名|
      |aaron|阿郎|
      |cogentsoft|高正|
      |disable|禁用|
      |quentin|清亭|
    当 我禁用第4个用户
    那么 我应该能看到:禁用用户成功
    
  场景: 启用用户
    假如 我已经以管理员cogentsoft身份登录
    而且 我在用户管理页面
    而且 有以下数据:
      |用户名|姓名|
      |aaron|阿郎|
      |cogentsoft|高正|
      |disable|禁用|
      |quentin|清亭|
    当 我启用第3个用户
    那么 我应该能看到:启用用户成功    

