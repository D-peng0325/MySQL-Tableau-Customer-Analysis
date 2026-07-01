基于MySQL与Tableau的客户购物偏好与忠诚度分析报告


一 项目简介

使用 MySQL 处理客户购物数据，再通过 Tableau 可视化呈现。从用户画像、商品偏好、购买行为到忠诚度分层，全面剖析客户特征，识别高价值用户，为营销策略提供数据支持。


二 数据说明


---

## 数据集字段详情

| 字段名 (Field Name) | 含义 (Description) |
| :--- | :--- |
| **Customer_ID** | 客户唯一标识符 |
| **Age** | 客户年龄 |
| **Gender** | 客户性别(男/女) |
| **Item_Purchased** | 客户购买的商品 |
| **Category** | 购买商品的类别 |
| **Purchase_Amount** | 购买金额(美元) |
| **Location** | 购买地点 |
| **Size** | 购买商品的尺码 |
| **Color** | 购买商品的颜色 |
| **Season** | 购买商品的季节 |
| **Review_Rating** | 客户对购买商品的评分 |
| **Subscription_Status** | 客户是否拥有订阅(是/否) |
| **Shipping_Type** | 客户选择的配送方式 |
| **Discount_Applied** | 是否应用了折扣(是/否) |
| **Promo_Code_Used** | 是否使用了优惠码(是/否) |
| **Previous_Purchases** | 客户在该商店的历史购买总数,不包括当前交易 |
| **Payment_Method** | 客户最常用的支付方式 |
| **Frequency_of_Purchases** | 客户购买频率(每周、每两周、每月等) |


---


## 示例数据表格


| Customer_ID | Age | Gender | Item_Purchased | Category | Purchase_Amount | Location | Size | Color | Season | Review_Rating | Subscription_Status | Shipping_Type | Discount_Applied | Promo_Code_Used | Previous_Purchases | Payment_Method | Frequency_of_Purchases |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 55 | Male | Blouse | Clothing | 53 | Kentucky | L | Gray | Winter | 3.1 | Yes | Express | Yes | Yes | 14 | Venmo | Fortnightly |
| 2 | 19 | Male | Sweater | Clothing | 64 | Maine | L | Maroon | Winter | 3.1 | Yes | Express | Yes | Yes | 2 | Cash | Fortnightly |
| 3 | 50 | Male | Jeans | Clothing | 73 | Massachusetts | S | Maroon | Spring | 3.1 | Yes | Free Shipping | Yes | Yes | 23 | Credit Card | Weekly |
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |
| 3898 | 46 | Female | Belt | Accessories | 33 | New Jersey | L | Green | Spring | 2.9 | No | Standard | No | No | 24 | Venmo | Quarterly |
| 3899 | 44 | Female | Shoes | Footwear | 77 | Minnesota | S | Brown | Summer | 3.8 | No | Express | No | No | 24 | Venmo | Weekly |
| 3900 | 52 | Female | Handbag | Accessories | 81 | California | M | Beige | Spring | 3.1 | No | Store Pickup | No | No | 33 | Venmo | Quarterly |


三 数据处理


3.1 数据导入


通过MySQL Workbench 新建一个数据库database，导入好下载的文件（文件类型选择csv utf-8），表格命名为shopping_trends。
<img width="460" height="688" alt="image" src="https://github.com/user-attachments/assets/41e636f3-89e1-4f1e-90cc-22eb08c4e521" />


3.2 数据预处理


第一步：查看数据


<img width="128" height="68" alt="屏幕截图 2026-07-01 175526" src="https://github.com/user-attachments/assets/a9422659-3b3b-46a2-b0ff-18b962a18447" />


<img width="980" height="227" alt="屏幕截图 2026-07-01 175554" src="https://github.com/user-attachments/assets/54819d22-5f99-4aac-89fa-0a72d94e48f8" />



结果正常


第二步：缺失值检测及处理


<img width="273" height="329" alt="屏幕截图 2026-07-01 173807" src="https://github.com/user-attachments/assets/5abc7877-c6e6-443b-be2d-5606eeb679c0" />


结果显示无缺失值


第三步：重复值检测及处理


<img width="677" height="278" alt="屏幕截图 2026-07-01 174001" src="https://github.com/user-attachments/assets/b2c79d65-c63d-4ea5-a980-ce305e2e0c58" />


四 数据分析


4.1 用户基本特征分析


通过描述性统计和可视化手段，对用户的年龄分布(Age)、性别比例(Gender)及地域集中度地域(Location)进行分析，呈现出用户群体的轮廓特征。


4.1.1 年龄分布


<img width="329" height="329" alt="屏幕截图 2026-07-01 174129" src="https://github.com/user-attachments/assets/80030a61-2ae4-4ab8-a9b1-fb3f7c265821" />
<br>
<img width="207" height="143" alt="屏幕截图 2026-07-01 174208" src="https://github.com/user-attachments/assets/ec1c6e5a-b202-4108-a203-f30e8f69bc87" />


4.1.2 性别比例


<img width="568" height="118" alt="屏幕截图 2026-07-01 175914" src="https://github.com/user-attachments/assets/3a9b6ad0-8b69-48a3-8992-d9d92a084b06" />
<br>
<img width="303" height="74" alt="屏幕截图 2026-07-01 175923" src="https://github.com/user-attachments/assets/f293e887-bd25-46aa-85a9-b6944605ed45" />


在Tableau中导入数据后，创建计算字段’年龄段’、’男性人数’、’女性人数’、’平均消费金额’。


<img width="384" height="161" alt="image-1" src="https://github.com/user-attachments/assets/3c0a89ac-5be2-485b-b6ea-34f3b5743da6" />
<br>
<img width="314" height="62" alt="image-2" src="https://github.com/user-attachments/assets/e2feb1b3-4b41-41d6-b874-9f29db7ccfa0" />
<br>
<img width="230" height="54" alt="image-3" src="https://github.com/user-attachments/assets/ea8293de-8cca-41e7-bbef-ace1b441b206" />
<br>
<img width="203" height="55" alt="image-4" src="https://github.com/user-attachments/assets/582f8f3e-8ad0-4bf7-b522-df4952a0874c" />
<br>
<img width="649" height="577" alt="image-5" src="https://github.com/user-attachments/assets/32ab9489-aa9f-4c70-acca-78aef5404f3b" />



4.1.3 地域集中度


<img width="289" height="146" alt="屏幕截图 2026-07-01 175941" src="https://github.com/user-attachments/assets/7f5d4fd5-8491-4ea3-893a-ee778dac5cff" />
<br>
<img width="453" height="212" alt="屏幕截图 2026-07-01 175934" src="https://github.com/user-attachments/assets/3bf32c27-a48a-4b02-a1ca-fe4cdfa5cc75" />
<br>
<img width="606" height="573" alt="image-6" src="https://github.com/user-attachments/assets/cffdf9ff-bd32-4115-a235-5d9e78048afe" />


4.1.4 小结


① 除了20岁以下的用户较少外，年龄分布均衡，男性用户整体多于女性，且平均消费水平均在60$左右。因此，产品的广告文案、视觉风格可偏向中性、成熟、稳重，避免仅针对年轻人的潮流表达。

② Montan地区客户数最多，Alaska地区平均消费金额最高，各地区可分析当地用户画像，及时调整产品品类结构与促销策略。


4.2 商品销售分析


4.2.1 畅销商品类别分析


<img width="284" height="148" alt="屏幕截图 2026-07-01 180728" src="https://github.com/user-attachments/assets/5a04f944-8065-4c23-a4e2-31b454c5a5fa" />
<br>
<img width="425" height="110" alt="屏幕截图 2026-07-01 180735" src="https://github.com/user-attachments/assets/2768f83e-35ba-4b22-afcd-c5e905ec452f" />
<br>
<img width="1096" height="581" alt="image-7" src="https://github.com/user-attachments/assets/20b2662b-cb30-4d89-9d18-bdfb66927e6b" />


4.2.2 商品颜色偏好分析


<img width="280" height="147" alt="屏幕截图 2026-07-01 180851" src="https://github.com/user-attachments/assets/15259592-0be8-4783-98fb-f4eb4fba1c13" />
<br>
<img width="406" height="212" alt="屏幕截图 2026-07-01 180903" src="https://github.com/user-attachments/assets/d36b70c0-0c79-42f3-954f-33f893a676c8" />
<br>
<img width="1091" height="584" alt="image-8" src="https://github.com/user-attachments/assets/6caa9786-b49c-4deb-b245-41ec3f715ebc" />


4.2.3 季节性销售趋势分析


<img width="279" height="136" alt="屏幕截图 2026-07-01 181006" src="https://github.com/user-attachments/assets/4097f836-14d7-469e-8946-878b9bc62212" />
<br>
<img width="410" height="107" alt="屏幕截图 2026-07-01 181013" src="https://github.com/user-attachments/assets/ce27ee51-cc52-4838-b682-721142527ea3" />
<br>
<img width="1096" height="581" alt="屏幕截图 2026-07-01 181248" src="https://github.com/user-attachments/assets/7dceb9be-4abb-4201-ac6e-e163407a14e7" />
<br>
<img width="850" height="533" alt="屏幕截图 2026-07-01 181320" src="https://github.com/user-attachments/assets/567da6ef-5645-4c75-a6fa-2d8af6aa4bf3" />
<br>
<img width="848" height="532" alt="屏幕截图 2026-07-01 181306" src="https://github.com/user-attachments/assets/a5291e2d-1e8d-4e31-8676-84d71213a859" />


4.2.4 小结


①Clothing是最畅销的商品类别，且总销售额最高。因此可将Clothing作为主打品类，加大款式更新与库存保障，并围绕其开发搭配商品（如Accessories）或推出季节限定系列。


② 颜色偏好方面，Olive色系的客户选择最多，Green色系的平均销售额最高。可在商品设计、广告视觉中优先采用这些流行色，并在商品详情页强化颜色筛选与推荐。


③季节性销售趋势显示，秋季的销售最为活跃，且不同季节的热销品类与颜色存在差异。可根据季节特点调整主推品类与主推色系，在旺季加大促销力度，在淡季可通过折扣或捆绑销售清理库存。


4.3用户购买行为特征分析


4.3.1支付方式偏好分析


<img width="584" height="113" alt="屏幕截图 2026-07-01 181453" src="https://github.com/user-attachments/assets/b2611773-65f6-4330-83b3-10cc1c58a0b0" />
<br>
<img width="377" height="140" alt="屏幕截图 2026-07-01 181459" src="https://github.com/user-attachments/assets/44a1fe8b-85ae-4684-9237-00432996ae7c" />


4.3.2 配送方式偏好分析


<img width="586" height="117" alt="屏幕截图 2026-07-01 181544" src="https://github.com/user-attachments/assets/094281f7-4975-475e-b126-8e4f6cd18501" />
<br>
<img width="484" height="143" alt="屏幕截图 2026-07-01 181559" src="https://github.com/user-attachments/assets/1a9cf9c7-4522-4276-9d5b-ab62d7a873a4" />
<br>
<img width="953" height="500" alt="image-9" src="https://github.com/user-attachments/assets/7d21c5db-4e4d-4fda-a1e1-efd8e3bf06ea" />


4.3.3 优惠活动效果分析


在创建’优惠组合字段’探究优惠码与折扣的叠加效果后，发现客户要么两者都使用，要么都不使用，并没有仅折扣或仅优惠码的情况，这可能与商家的促销活动有关，因此选择折扣这一指标探究优惠活动效果。


<img width="383" height="157" alt="image-10" src="https://github.com/user-attachments/assets/2ba23010-d875-4132-b546-84303fa4ae92" />
<br>
<img width="188" height="322" alt="image-11" src="https://github.com/user-attachments/assets/5df17adb-a24b-499e-973d-b91f45a45272" />
<br>
<img width="1014" height="581" alt="image-12" src="https://github.com/user-attachments/assets/bdaaea04-5268-46ea-930b-51fef481f9ca" />


4.3.4 小结


① PayPal、Credit Card、Cash是用户常用的支付方式，Free Shipping配送方式使用频率最高。可以优化支付方式的支付体验、同时调整运费策略，提升支付以及配送的服务质量，以提高用户满意度。


②使用优惠的比没有使用优惠的平均消费金额低0.85，优惠的使用在不同品类、支付方式、购买频率上分布较为均匀，但与订阅状态存在强关联。这也说明了优惠活动可能主要面向订阅用户，且折扣与优惠码绑定使用，缺乏灵活的选择空间。建议简化优惠规则，根据用户的不同偏好，设计更好的营销活动。


4.4 高复购客户分析


4.4.1 历史购买次数分析


<img width="583" height="196" alt="屏幕截图 2026-07-01 201521" src="https://github.com/user-attachments/assets/75996604-65b4-4865-bc9a-887a65abbb27" />
<br>
<img width="329" height="107" alt="屏幕截图 2026-07-01 201532" src="https://github.com/user-attachments/assets/ec622830-b8b6-41fe-bf31-9949ff20e9ef" />


4.4.2 购买频率分析


<img width="541" height="343" alt="image-13" src="https://github.com/user-attachments/assets/f7524713-7c02-49d2-8057-31b4fb360966" />
<br>
<img width="680" height="158" alt="image-14" src="https://github.com/user-attachments/assets/3680d98a-ab09-4cf1-9379-b9ba6d8ce509" />
<br>
<img width="385" height="158" alt="image-15" src="https://github.com/user-attachments/assets/4ec4d7ca-4004-451f-996d-696be1f2c729" />
<br>
<img width="1025" height="575" alt="image-16" src="https://github.com/user-attachments/assets/3e406513-7c51-4580-a416-743f57ef4a45" />


4.4.3 高复购用户的特征


定义高复购用户：历史购买次数大于5次且购买频率至少为两周一次的用户


<img width="758" height="200" alt="image-17" src="https://github.com/user-attachments/assets/9059f1b2-2d00-4fdc-9cdc-8ac9cb7af7aa" />
<br>
<img width="278" height="54" alt="image-18" src="https://github.com/user-attachments/assets/5d44f63c-5e63-4ade-9e6e-a2d5604bb3a8" />
<br>
<img width="383" height="158" alt="image-19" src="https://github.com/user-attachments/assets/c8c1f05a-36de-4f1b-ade9-1d25cea39c50" />
<br>
<img width="1033" height="572" alt="image-20" src="https://github.com/user-attachments/assets/5f3274c6-2a5b-467f-990d-0dc01431febf" />


4.4.4 小结


高复购用户占总用户数的37%，虽然高复购用户在商品类别的选择上差异不大，但在颜色、支付方式、配送方式上均有差异。建议针对高复购用户设计专属权益（如会员等级、专属折扣），提升其粘性；同时通过推送高频品类、订阅服务等方式，引导中低频用户向高复购转化。


4.5 忠诚度分析


忠诚度指标体系构建


---


| 具体指标 | 说明 | 权重 |
|---------|------|------|
| **行为忠诚** | | |
| Previous_Purchases | 历史购买次数。多次购买说明客户对产品与服务已形成依赖，且持续满意。 | 0.25 |
| Frequency_of_Purchases | 购买频率。根据Bi-Weekly（一周两次）、Weekly（一周一次）、Fortnightly（两周一次）、Monthly（一月一次）、Every 3 Months（三月一次）、Quarterly（一季一次）、Annually（一年一次）分别编码7-1。 | 0.2 |
| Purchase_Amount | 消费金额。考虑到品类差异，将低于同品类消费金额平均值0.8倍的划分为低消费、在同品类消费金额平均值0.8倍-1.2倍之间的划分为中等消费、高于同品类消费金额平均值1.2倍的划分为高消费，分别编码为1、2、3。 | 0.2 |
| Discount_Applied | 是否使用折扣，使用则记为0，未使用则记为1。因为通常忠诚客户对价格敏感度较低，折扣使用比例可能更低。 | 0.05 |
| **态度忠诚** | | |
| Review_Rating | 客户对本次购买的评分（1-5分）。高分客户可能更满意，忠诚度更高。 | 0.15 |
| **关系稳定** | | |
| Subscription_Status | 是否订阅会员，订阅则记为1，非订阅则记为0。订阅用户通常具有更高粘性和忠诚度。 | 0.15 |


第一步：对各个指标赋值


<img width="678" height="379" alt="image-21" src="https://github.com/user-attachments/assets/0af061b0-89eb-4357-9444-5a26d6ecae1f" />


第二步：对每个指标进行Min-Max归一化，使其得分范围统一映射到0-100之间，公式如下：


<img width="373" height="175" alt="image-22" src="https://github.com/user-attachments/assets/43877d31-295f-4c27-a4f6-6967220b1fb7" />
<br>
<img width="656" height="162" alt="image-23" src="https://github.com/user-attachments/assets/e62e2184-15b4-4a35-94d7-952f1f7de860" />


第三步：赋权得到忠诚度指数，进而划分为五个等级，0-20忠诚度极低、20-40忠诚度低、40-60忠诚度中等、60-80忠诚度高、80-100忠诚度极高。


<img width="548" height="231" alt="image-24" src="https://github.com/user-attachments/assets/ae87b944-731e-49b4-bec5-2c37b42bd817" />
<br>
<img width="207" height="127" alt="image-25" src="https://github.com/user-attachments/assets/2d723e2b-c323-426f-a91d-1e040f7ba607" />
<br>
<img width="783" height="645" alt="image-26" src="https://github.com/user-attachments/assets/33696a85-37d3-4130-a495-cd89f74a1e7e" />
<br>
<img width="943" height="546" alt="image-27" src="https://github.com/user-attachments/assets/f50612f6-d50f-4207-9a82-d32f21af24c0" />
<br>
<img width="960" height="479" alt="image-28" src="https://github.com/user-attachments/assets/e5af7308-f2b8-4ba2-8a84-5242910516a7" />
<br>
<img width="458" height="532" alt="image-29" src="https://github.com/user-attachments/assets/24c41968-7bea-47b5-854c-12a57e75f6b2" />


小结


①忠诚度极低（0-20分）为沉睡用户，占比3.1%，他们可能只是尝试性购买，对品牌几乎没有粘性，复购概率极低。

营销策略：暂不投入高成本，可通过推送大额优惠券或爆款推荐，尝试激活；若长期无反应，可考虑放弃。

②忠诚度低（20-40分）为低频用户，占比30.7%，这些用户对价格敏感，品牌忠诚度尚未形成，容易被竞品吸引，但仍有转化潜力。

营销策略：推送组合折扣、满减活动，鼓励提高客单价；推荐高频品类培养购买习惯；尝试引导订阅会员获取权益。

③忠诚度中等（40-60分）为普通活跃用户，占比47.2%，这些用户已形成一定购买习惯，对品牌有基本信任，是维持销售额的中坚力量。

营销策略：保持关系维护，提供更多基础权益，如积分兑换、满额包邮等，鼓励向高忠诚度升级。

④忠诚度高（60-80分）为忠诚粉丝，占比17.9%，大都是品牌的核心用户，复购稳定，愿意为品质支付溢价，且可能自发传播。

营销策略：提供专属会员等级、生日礼遇、优先购、专属客服等VIP服务；邀请参与新品内测或品牌活动，增强归属感与口碑。

⑤忠诚度极高（80-100分）为超级用户，占比1.1%，是品牌的最有价值用户，贡献度高，是口碑传播的核心力量，可能成为品牌大使。

营销策略：建立一对一维护机制，提供定制化服务、限量款优先权、年度答谢礼；鼓励其分享推荐，给予推荐奖励或联名机会。


五 总结


1 用户画像：各个年龄段分布还算均匀，男性用户略多，平均消费差别不大。Montana客户最多，Alaska人均消费最高。稳重、中性风格的广告和产品设计更能覆盖主流人群。不同地区的消费力有高有低，后续可以针对性地调整品类和促销策略。

2 商品销售：Clothing是绝对主力，销量和销售额都排第一，颜色上Olive最受欢迎，Green虽然量不大但客单价高。秋季销量高，不同季节热销品类和颜色也有变化。后续可以主推Clothing，根据季节调整主色调和品类，旺季加大力度，淡季清库存。

3 购买行为：支付方式上PayPal、信用卡、现金排前三，免邮配送最受欢迎。使用优惠的客户平均消费比未使用优惠的低，且优惠和订阅强相关，几乎都是捆绑使用。说明现在的优惠规则比较死板，可以加以优化，给不同用户更灵活的选择。

4 高复购客户：占总用户37%，这部分人在颜色、支付、配送上跟普通用户不太一样，但品类偏好差别不大。可以对其试用会员权益、专属折扣等，稳住基本盘，另外可以通过推荐高频品类、引导订阅等拉动中低频客户。

5 忠诚度分层：从行为、态度、关系三个角度打分，把客户分成五个层级。极低忠诚的沉睡用户不用强留，低忠诚的可试用优惠激活，中等忠诚的关系维持好，高忠诚度与超级用户群体，应构建专属维护体系，通过VIP服务、定制化权益及推荐激励机制，提升其归属感与品牌认同，引导其成为品牌的自发传播者。
