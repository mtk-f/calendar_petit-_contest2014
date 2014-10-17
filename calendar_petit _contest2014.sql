/*
 * #カレンダープログラミング プチコンテスト 2014
 * Transact-SQL
 * SQL Server 2008 R2用
 * 
 * MSDNには2008R2でWEEKDAY関数が使えるって書いてあるけど
 * なぜか使えなかったので言語設定に依存してます
 * 
 * 日本語環境のみ
 * IF @@LANGUAGE!='日本語' RETURN
 * 
 * 実行中に日付が変わっても日付が変わる前の月のカレンダーを表示するはず
 * 
 * SQL Server 2012ならDATEFROMPARTS関数でちょっと短くなる
 * SQL Server 2000では動作不可（対応可能だけど長くなる）
 * 
 * 2014/10 Mtk Fujiu.jp
 */
DECLARE @G DATE=GETDATE()
DECLARE @M INT=MONTH(@G)
DECLARE @D DATE=CONVERT(CHAR(4),YEAR(@G))+'-'+CONVERT(VARCHAR(2),@M)+'-1'
DECLARE @W NCHAR(1)
DECLARE @T VARCHAR(20)=''
WHILE MONTH(@D)=@M BEGIN
	SET @T+=RIGHT(' '+CONVERT(VARCHAR(2),DAY(@D)),2)
	SET @W=DATENAME(w,@D)
	IF @W!='土'
		SET @T+=' '
	ELSE BEGIN
		PRINT RIGHT(SPACE(18)+@T,20)
		SET @T=''
	END
	SET @D=DATEADD(d,1,@D)
END
IF @W!='土' PRINT @T


/*
 * 2014年10月の実行結果
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30 31 
*/
