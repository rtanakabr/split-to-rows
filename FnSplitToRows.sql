/*

Split to Rows - SQL Server 2016 or lower split function.
Created by Ricardo Tanaka

*/

CREATE FUNCTION FnSplitToRows(@Separator VARCHAR(1), @Text NVARCHAR(4000)) RETURNS @Output TABLE ([TextValue] NVARCHAR(1000))
AS
	BEGIN
		
		DECLARE @SepQty INT = (SELECT LEN(@Text) - LEN(REPLACE(@Text, @Separator, '')))
		DECLARE @Counter INT = 0

		DECLARE @TextValue NVARCHAR(1000)

		WHILE (@Counter <= @SepQty)
			BEGIN
				IF(@Counter = @SepQty)
					BEGIN
						SELECT
							@TextValue = @Text
					END
				ELSE
					BEGIN
						SELECT
							@TextValue = SUBSTRING(@Text, 1, CHARINDEX(@Separator, @Text)-1)
							, @Text = SUBSTRING(@Text, CHARINDEX(@Separator, @Text) + 1, (LEN(@Text) - LEN(SUBSTRING(@Text, 1, CHARINDEX(@Separator, @Text) - 1))))
					END

				INSERT INTO @Output ([TextValue]) VALUES (@TextValue)

				SET @Counter += 1
			END

		RETURN

	END
