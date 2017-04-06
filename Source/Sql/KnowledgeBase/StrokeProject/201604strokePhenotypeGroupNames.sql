

update PH set GRP = 'INTRACEREBRAL HEMORRHAGE' where PH in ('Stroke_deep', 'Stroke_lobar', 'Stroke_all');
update PH set GRP = 'ISCHEMIC STROKE' where PH in ('Stroke_CE', 'Stroke_IS', 'Stroke_LVD', 'Stroke_SVD');

update PH set SORT = 33 where PH = 'Stroke_IS';
update PH set SORT = 34 where PH = 'Stroke_CE';
