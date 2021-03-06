功能: 管理待办事项
  为了方便快捷地处理当前工作事项
  作为工作人员
  可以受理,转办,审核,办结事件

  场景大纲: 受理事件
    假如 我已经以用户depart身份登录
    而且 我在待办事项页面
    而且 有以下<状态>的事项:
      |事件编号|事件主题|登记时间|登记人|
      |(警)深电2009032300099|马先生投诉|03-24 22:22|清亭|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|
    而且 我在待办事项页面
    当 我在第1条记录中点击处理按钮
    那么 我应该能看到:<状态>
    而且 我应该能看到:处理过程
    而且 我应该能看到:往来记录
    而且 我应该能看到:阿郎
    当 我选中<办理方式>
    而且 我点击提交
    那么 我将看到以下数据:
      |事件编号|事件主题|登记时间|登记人|状态|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|<状态>|
      |深电2009032300099|马先生投诉|03-24 22:22|清亭|已受理|

    例子:
      | 状态 | 办理方式 |
      |待处理| 受理     |
      |已退回| 受理     |
      |待重办| 受理     |

  场景大纲: 处理事件
    假如 我已经以用户depart身份登录
    而且 我在待办事项页面
    而且 有以下<状态>的事项:
      |事件编号|事件主题|登记时间|登记人|
      |(警)深电2009032300099|马先生投诉|03-24 22:22|清亭|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|
    而且 我在待办事项页面
    当 我在第1条记录中点击处理按钮
    那么 我应该能看到:<状态>
    而且 我应该能看到:处理过程
    而且 我应该能看到:往来记录
    而且 我应该能看到:阿郎
    当 我选中<办理方式>
    而且 我选择接收部门为<接收部门>
    而且 我选择相关责任人为<相关责任人>
    而且 我点击提交
    那么 我将看到以下数据:
      |事件编号|事件主题|登记时间|登记人|状态|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|<状态>|

    例子:
      | 状态 | 办理方式 | 接收部门 | 相关责任人 |
      |待处理| 转办     |  劳动局  |  阿郎      |
      |待处理| 申请办结 |  劳动局  |  阿郎      |
      |待处理| 退回     |  未选择  |  未选择    |
      |已受理| 转办     |  劳动局  |  阿郎      |
      |已受理| 申请办结 |  劳动局  |  阿郎      |
      |已退回| 转办     |  劳动局  |  阿郎      |
      |待重办| 转办     |  劳动局  |  阿郎      |
      |待重办| 申请办结 |  劳动局  |  阿郎      |
      |待审核| 确认办结 |  未选择  |  未选择    |
      |待审核| 退回重办 |  未选择  |  未选择    |

  场景: 添加往来记录
    假如 我已经以用户depart身份登录
    而且 我在待办事项页面
    当 我在第2条记录中点击添加往来记录按钮
    那么 我应该能看到: 孙先生投诉物业 物业管理不到位,小区经常发生偷窃事件
    而且 我应该能看到往来记录:
      |03-23 孙小 来访|
    而且 我应该能看到处理过程:
      |03-25 (劳动局)阿郎 转办 (劳动局)机构人员 : 转你处办理| 
    而且 我选中孙小
    而且 我选中回电
    而且 我输入内容摘要为通知联系人,已经对非法营业摊档进行清理
    当 我点击保存
    那么 我应该能看到:保存成功

  @focus
  场景: 待办事项显示预警标记
    假如 我已经以用户depart身份登录
    而且 我在待办事项页面
    那么 我将看到以下数据:
      |事件编号|事件主题|登记时间|登记人|
      |(警)深电2009032300099|马先生投诉|03-24 22:22|清亭|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|
