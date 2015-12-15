declare c cursor for
 select name from sysobjects where type = 'v' and uid = 1
 open c
 declare @ViewName varchar(500)
 fetch next from c into @ViewName
 while @@fetch_status = 0
 begin
 BEGIN TRY
exec sp_refreshView @viewName
 END TRY
 BEGIN CATCH
 print @viewName
 END CATCH
 fetch next from c into @viewName
 end
 close c
 deallocate c