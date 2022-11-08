![image](https://raw.githubusercontent.com/PancakePrediction/Pancake_Pridction_KNN/main/imgs/001.png)

# Pancake_Prediction_KNN
Đối với Pancake Prediction, hãy thử sử dụng thuật toán KNN để dự đoán.
## Các tính năng bao gồm
1. Bạn có thể theo dõi biểu đồ để đặt cược nhanh.
2. Nếu bạn giành chiến thắng trong vòng vừa rồi, script sẽ tự động claim giải thưởng.
3. Fee claim và fee gas đặt cược đã được tối ưu nhỏ nhất. Mức cược nhỏ nhất đảm bảo là từ 0.003BNB
4. Nếu bạn thua vòng rồi, bạn có thể nhấp vào nút `+ gấp đôi` để đặt cược vòng tiếp theo.
5. Bạn có thể thu thập nhiều mẫu thử hơn cho KNN bằng cách chạy bot thô rồi mở chế độ tự động cược.
## Donate
Đây là script miễn phí nhưng nếu bạn thấy hay có thể gửi tớ ít cafe ở địa chỉ này nhé.
ETH/BNB: 0x8eAD51d74CD75e6d456eE35769C8561aD339C26C

## Cách bật KNN và chạy thử để lấy mẫu thử
1. Tạo một Database MSSQL DB đặt tên là `StockData`.
2. Tạo một bảng `RoundData` trong CSDL `StockData` và copy code phía dưới chạy query (Nên sử dụng Database trong Visual Studio hoặc SQL Server 2019, sử dụng Microsoft SQL Server Management Studio 18):
```
USE [StockData]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoundData](
	[RoundID] [int] NOT NULL,
	[Last10sChange] [float] NULL,
	[LinkPriceSecounds] [int] NULL,
	[Offset] [float] NULL,
	[KDChange] [float] NULL,
	[Trend] [float] NULL,
	[KDRatio2] [float] NULL,
	[KDRatio3] [float] NULL,
	[Change] [float] NULL,
	[UpShadowLine] [float] NULL,
	[DownShadowLine] [float] NULL,
	[OnBollMiddle] [float] NULL,
	[IsBull] [bit] NULL,
	[ChangeBefore] [float] NULL,
	[K2] [float] NULL,
	[D2] [float] NULL,
	[K3] [float] NULL,
	[D3] [float] NULL,
	[BollWidth] [float] NULL,
	[BollChange] [float] NULL,
	[Change10m] [float] NULL,
	[Change15m] [float] NULL,
	[Change20m] [float] NULL,
	[Change25m] [float] NULL,
 CONSTRAINT [PK_RoundData1] PRIMARY KEY CLUSTERED 
(
	[RoundID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
```

3. Tạo tiếp một bảng tên `RoundData_Prediction` trong CSDL `StockData` bằng code phía dưới:
```
USE [StockData]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoundData_Prediction](
	[RoundID] [int] NOT NULL,
	[PredictionIsBull] [bit] NULL,
	[PredictionIsBull2] [bit] NULL,
	[PredictionIsBullV2] [bit] NULL,
	[PredictionIsBullV3_0123] [bit] NULL,
	[PredictionIsBullV1_0123] [bit] NULL,
	[Score] [float] NULL,
	[TestSetAccuracy] [float] NULL,
	[kValue] [int] NULL,
	[AgainstPercent] [float] NULL,
 CONSTRAINT [PK_RoundData_Prediction1] PRIMARY KEY CLUSTERED 
(
	[RoundID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
```
4. Điền thông số cần thiết vào SQL ở file config.


## Hỗ trợ:
Discord: https://discord.gg/cckmzv8ACm
Telegram: @trungan1511

## Thiết lập thông số
File config ở `Config\AppConfig.json` nó sẽ có dạng như thế này:
```
{
  "faildCount": 4,					//Lưu số lần fail.
  "betAmountInBNB": 0.003,				//Lượng BNB cược.
  "AutoBet": false,					//false là tắt tự cược, true = bật. Khi chạy trong Vkisual Studio, bạn vẫn có thể set thủ công cái này
  "Proxy": "",						//Bạn bỏ trống cũng được, thêm proxy cũng được
  "DbServerName": "localhost",				//Nếu để trống thì KNN sẽ chạy, còn set về localhost thì sẽ chạy lấy mẫu trực tiếp
  "dbName": "StockData",				//Tên CSDL, cứ để là "StockData"
  "dbUser": "stockdataUser",				//Username lúc setup ở SQL Server
  "dbPassword": "stockdataUserPassword",		//Password
  "websocketNode": "https://rpc.ankr.com/bsc",		//Bạn có thể chọn socket khác tốt hơn, nma mình khuyên cứ để thế này
  "wallletPrivateKey": "",				//Cái này bạn vào Metamask, export privatekey rồi paste vào đây nhé
  "rpc_Endpoint": "https://bsc-dataseed1.binance.org/"	//RPC Endpoint trỏ về, cứ để vậy
}
```

### API tốt cho node
Bạn có thể tham khảo thêm các chỗ lấy WS mượt khác như
https://ankr.com/
https://www.quicknode.com/


## Chạy script
Để chạy thì bạn phải setup hết như trên, vào Visual Studio Code và Build file, Debug và chạy thôi.

## Về thuật toán KNN
1. Giá trị K nên set ở 26 thôi nhé. Mặc định là 26 (Tỉ lệ win 61.33%; Lost tối đa: 5 ván, mẫu thử: 2000 mẫu)
2. Càng nhiều mẫu thì tỉ lệ chính xác càng cao.

## Cảnh báo
1. Chơi biết chừng biết mực và bạn phải biết mình đang chạy cái gì. Tiền là của bạn và chơi hay không là quyền của bạn.
2. Mình từng kiếm từ 0.05BNB lên 2BNB 1 ngày. 
3. Nhưng cũng có lúc nổ cái chuỗi thua từ 5BNB về 0.1BNB.
4. Mình đã tắt chế độ gấp đôi đến chết. Đây là cơ chế rất nguy hiểm. 
## Cơ chế gấp đôi đến chết (đã tắt, có hướng dẫn mở)
Bạn thua khi điểm của vòng đó < giá trị trung bình của các vòng thử trong 20 mẫu gần nhất => Gấp đôi.
+ Nếu win thì reset về mức cược ghi trong ô cược ban đầu hoặc trong file config.
+ Nếu lost tiếp thì sẽ tính tiếp điểm vòng đó, khi < giá trị trung bình của các vòng thử trong 20+1 mẫu gần nhất và < max balance ví bạn => cược.
+ Vòng lặp sẽ vô hạn nếu chuỗi thua cứ tiếp diễn. Hãy tắt bot và chạy lại thay vì tắt chế độ tự cược. Vì khi mở lại, bot sẽ lấy giá trị cược được lưu ưu tiên thay vì giá trị điền trên ô.
+ Hiện đã tắt nên khi lost, bot vẫn chỉ đặt mức ban đầu trong config.
# Hướng dẫn mở gấp đôi
Sẽ cập nhật sau...
