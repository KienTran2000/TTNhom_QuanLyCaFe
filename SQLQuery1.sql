create proc xoachude @idCategory int
as
begin
	select id=@idCategory from dbo.FoodCategory 
	print @idCategory
	begin
	declare @idFood int
	select id=@idFood from dbo.Food where idCategory=@idCategory
	print  @idFood
	
	declare @idBill int
	select id=@idBill from dbo.BillInfo where idFood=@idFood
	print  @idBill

	delete BillInfo where id=@idBill
	delete Food where id=@idFood
	end
	delete FoodCategory where id=@idCategory
	

end

exec xoachude 6
drop proc xoachude

CREATE TRIGGER DeleteCate ON FoodCategory INSTEAD OF DELETE
AS
DECLARE @MA INT
BEGIN
	SELECT @MA = ID FROM deleted
	DELETE BillInfo WHERE idFood IN (SELECT ID FROM Food WHERE idCategory = @MA)
	DELETE Food WHERE idCategory = @MA
	DELETE FoodCategory WHERE ID = @MA
END

delete dbo.FoodCategory where id=6 
create trigger DeleteTable on TableFood instead of delete
as
declare @MATable int
begin
	select @MATable=ID from deleted
	delete BillInfo where idBill in(select id from Bill where idTable=@MATable)
	delete Bill where idTable=@MATable
	delete TableFood where id=@MATable
end