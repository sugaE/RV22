function catogories = fetchLabels(val_dir)

% Read all the labels in val set
val_dirs = dir(val_dir);
catogories = [];
for k = 1 : length(val_dirs)
  thisdir = val_dirs(k).name;
  if startsWith(thisdir, "n")
    catogories= cat(2, catogories, string(thisdir)); 
  end
end

