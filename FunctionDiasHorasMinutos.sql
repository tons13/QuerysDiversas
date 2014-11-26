/* 
Function retorna dias, horas e minutos a partir do @TIPO selecionado.
Ex:
@TIPO 
		1 dias
		2 horas
		3 minutos

	
*/
CREATE FUNCTION [dbo].[FnDiasHorasMinutos]
(
	 @DT_INICIAL		DATETIME
	,@DT_FINAL			DATETIME
	,@TIPO				INT
)
RETURNS INT
BEGIN
	
	-- Valor que vai armazenar dias, horas ou minutos.
	DECLARE @DIASHORASMINUTOS INT 

	-- Inicia a variavel com 0
	SET @DIASHORASMINUTOS = 0

	DECLARE @DIA_EM_MIN INT, @HORA_EM_MIN INT, @MIN_RESTANTES INT, @QTD_DIAS INT, @QTD_HORAS INT , @QTD_MINUTOS INT
	
	IF DATEDIFF(DAY, @DT_INICIAL, @DT_FINAL) > 0 OR DATEDIFF(HOUR, @DT_INICIAL, @DT_FINAL) > 0 OR DATEDIFF(MINUTE, @DT_INICIAL, @DT_FINAL) > 0
		BEGIN
			SET @MIN_RESTANTES = DATEDIFF(MINUTE, @DT_INICIAL, @DT_FINAL)
		END
	ELSE
		BEGIN
			SET @MIN_RESTANTES = - DATEDIFF(MINUTE, @DT_INICIAL, @DT_FINAL)
		END
		
			-- Inicia as variaveis com 0
			SET @QTD_DIAS = 0
			SET @QTD_HORAS = 0
			SET @QTD_MINUTOS = 0
						
			-- Um dia tem 1440 minutos
			SET @DIA_EM_MIN = 1440
			
			-- Uma hora tem 60 minutos
			SET @HORA_EM_MIN = 60
		
		
		
		 -- Enquanto minutos restantes for maior igual que dia em minutos
		 -- adiciona 1 na quantidade de dias
			WHILE (@MIN_RESTANTES >= @DIA_EM_MIN)
				BEGIN
					SET @QTD_DIAS = @QTD_DIAS + 1
					SET @MIN_RESTANTES = @MIN_RESTANTES - @DIA_EM_MIN
				END
				
		 -- Enquanto minutos restantes for maior igual que horas em minutos
		 -- adiciona 1 na quantidade de horas
			WHILE (@MIN_RESTANTES >= @HORA_EM_MIN)
				BEGIN
					SET @QTD_HORAS = @QTD_HORAS + 1
					SET @MIN_RESTANTES = @MIN_RESTANTES - @HORA_EM_MIN
				END
			
		-- Minutos restantes
			SET @QTD_MINUTOS = @MIN_RESTANTES
	
	IF @TIPO = 1 
	BEGIN
		set @DIASHORASMINUTOS =  @QTD_DIAS
	END 

	IF @TIPO = 2
	BEGIN 
		set @DIASHORASMINUTOS = @QTD_HORAS
	END 

	IF @TIPO = 3 
	BEGIN 
		set @DIASHORASMINUTOS  = @QTD_MINUTOS
	END

	RETURN @DIASHORASMINUTOS
	
END



