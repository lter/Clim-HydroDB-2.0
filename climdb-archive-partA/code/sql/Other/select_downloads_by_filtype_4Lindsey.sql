select file_type,count(*) from download
where datetime between '20100101' and '20101231'
group by file_type
