function b = pathscompare(path1, path2, options)

b = 0;

if ~exist('options','var')
    options = '';
end
if optionExists(options,'nameonly')
    b = pathsCompareNameOnly(path1, path2);
    return;
end

if exist(path1,'file') ~= exist(path2,'file')
    return;
end
if exist(path1,'file')==0
    return;
end
if exist(path2,'file')==0
    return;
end


% If paths are files, compare just the file names, then the folders
if exist(path1,'file')==2
    [p1,f1,e1] = fileparts(path1);
    [p2,f2,e2] = fileparts(path2);
    if ~strcmpi([f1,e1], [f2,e2])
        return;
    end
    path1 = p1;
    path2 = p2;
end

fullpath1 = path1;
fullpath2 = path2;

% Compare folders
currdir = pwd;

if exist(path1,'dir')==7
    cd_safe(path1);
    fullpath1 = pwd;
else
    return;
end

cd(currdir);

if exist(path2,'dir')==7
    cd_safe(path2);
    fullpath2 = pwd;
else
    return;
end

b = strcmpi(fullpath1, fullpath2);

cd(currdir);



% ------------------------------------------------------------------
function b = pathsCompareNameOnly(path1, path2)
b = 0;
if ispc()
    path1 = lower(path1);
    path2 = lower(path2);
end
p1 = str2cell(path1,{'\','/'});
p2 = str2cell(path2,{'\','/'});
if length(p1) ~= length(p2)
    return;
end
for ii = 1:length(p1)
    if ~strcmp(p1{ii},p2{ii})
        return
    end
end
b = true;
