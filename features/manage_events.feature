功能: 管理事件
  为了将来能够快速查找事件
  作为业务操作员
  可以新增,修改,删除事件

  场景: 来电弹窗
    假如 我已经以用户aaron身份登录
    当 系统弹出13988889999的来电录入窗口
    那么 我应该能看到输入的值:13988889999
    而且 我应该能看到:情况1:楼下太吵了
    而且 我应该能看到连续的内容: 03-24 马可波罗 来电 求助
    当 我输入13988889999的来电信息
    而且 我点击保存,接着修改
    那么 我应该能看到:保存成功
    而且 我应该能看到输入的值:13988889999

  场景: 新增来电
    假如 我已经以用户aaron身份登录
    而且 我在来电管理页面
    当 我输入13988889999的来电信息
    当 我点击保存,接着修改
    那么 我应该能看到:保存成功
    而且 我应该能看到输入的值:13988889999

  场景: 继续新增来电
    假如 我已经以用户aaron身份登录
    而且 我在来电管理页面
    当 我输入13988889999的来电信息
    当 我点击保存,继续新增
    那么 我应该看不到输入的值:13988889999

  场景: 更新来电
    假如 我已经以用户aaron身份登录
    而且 我新增13988889999的来电
    当 我输入来电人姓名为新马可波罗
    而且 我点击保存,接着修改
    那么 我应该能看到:更新成功
    而且 来电人姓名变为新马可波罗 

  场景: 查询来电
    假如 我已经以用户aaron身份登录
    假如 我在来电管理页面 
    当 我进入查询来电链接
    而且 我输入来电人姓名为马可波罗
    当 我点击查询
    那么 我将看到以下数据:
      |来电编号|来电主题|来电人|来电电话|来电时间|登记人|
      |深电2009032300099|马可波罗__投诉__区长热线办公室|马可波罗|13988889999|03-24 22:22|清亭|

  场景: 查看来电
    假如 我已经以用户aaron身份登录
    而且 我新增13988889999的来电
    假如 我在来电管理页面
    当 我进入查询来电链接
    而且 我在第1条记录中点击查看按钮
    那么 我应该能看到:13988889999
    而且 我应该能看到连续的内容:03-23 孙敏 来电 投诉
    而且 我应该能看到连续的内容:03-24 马可波罗 来电 投诉

  场景: 删除来电
    假如 我已经以用户aaron身份登录
    假如 我在来电管理页面
    当 我进入查询来电链接
    而且 我在第1条记录中点击删除按钮
    那么 我将看到以下数据:
      |来电编号|来电主题|来电人|来电电话|来电时间|登记人|
      |深电2009032300022|孙敏__咨询__区长热线办公室|孙敏|13911112222|03-23 14:14|清亭|