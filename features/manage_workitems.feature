功能: 管理待办事项
  为了方便快捷地处理当前工作事项
  作为工作人员
  可以受理,转办,审核,办结事件

  场景大纲: 受理事件
    假如 我已经以用户aaron身份登录
    而且 我在待办事项页面
    而且 有以下<状态>的事项:
      |事件编号|事件主题|登记时间|登记人|
      |深电2009032300022|孙敏__咨询__区长热线办公室|03-23 14:14|清亭|
      |深电2009032300099|马可波罗__投诉__区长热线办公室|03-24 22:22|清亭|
    而且 我在待办事项页面
    当 我在第1条记录中点击处理按钮
    那么 我应该能看到:13911112222
    而且 我应该能看到:办理过程
    而且 我应该能看到:阿郎
    当 我选中<办理方式>
    而且 我选择接收部门为<接收部门>
    而且 我选择相关责任人为<相关责任人>
    而且 我点击保存
    那么 我将看到以下数据:
      |事件编号|事件主题|登记时间|登记人|状态|
      |深电2009032300099|马可波罗__投诉__区长热线办公室|03-24 22:22|清亭|<状态>|

    例子:
      | 状态 | 办理方式 | 接收部门 | 相关责任人 |
      |待处理|  转办    |  劳动局  |  阿郎      |
      |待处理|  受理    |  未选择  |  未选择    |
      |待处理| 申请办结 |  劳动局  |  阿郎      |
      |待处理|  退回    |  未选择  |  未选择    |
      |已受理|  转办    |  劳动局  |  阿郎      |
      |已受理| 申请办结 |  劳动局  |  阿郎      |
      |已退回|  转办    |  劳动局  |  阿郎      |
      |已退回|  受理    |  未选择  |  未选择    |
      |待重办|  转办    |  劳动局  |  阿郎      |
      |待重办|  受理    |  未选择  |  未选择    |
      |待重办| 申请办结 |  劳动局  |  阿郎      |
      |待审核| 确认办结 |  未选择  |  未选择    |
      |待审核| 退回重办 |  未选择  |  未选择    |
