% If the compile fails, add  '-std=c++11' at the end of CFLAG and CXXFLAGS
% inside mexopts.sh. 
% If you don't know where `mexopts.sh` is, type `mex -v -n` and read the
% output carefully. 
% 
% 1. change mexopts.sh and add '-std=c++11' to CXXFLAGS
% 2. make('all','-lGL -lGLU -losg -losgDB -losgGA -losgViewer -losgUtil');
if ~exist('DEBUG','var')
    DEBUG = false;
end

if DEBUG
    DEBUG_FLAG = 'debug';
else
    DEBUG_FLAG = 'all';
end

% Set library path
% setenv('LIBRARY_PATH','/usr/local/lib64/');

if isunix && ~ismac
  system('rm bin/Renderer_.mexa64');
  % SW Rendering
  % make(DEBUG_FLAG,'-lGL -lGLU -losg -losgDB -losgGA -losgViewer -losgUtil -I./include/osg/ -L./lib/osg/ -L./lib/mesa/');
  % make(DEBUG_FLAG,'-lGL -lGLU -losg -losgDB -losgGA -losgViewer -losgUtil -I./include/osg/');
  make(DEBUG_FLAG,'CXXFLAGS=''$CXXFLAGS -fPIC -std=gnu++0x -static-libstdc++''','-I/usr/local/include -L/usr/local/lib -losg -losgViewer -losgDB -losgGA -losgUtil -lOpenThreads');
end

% For mac llvm
%
% 1. add to mlibs -framework OpenGL
% 2. change mexopts.sh and add '-std=c++11' to CXXFLAGS
% 3. make('all','-I/usr/local/include -losg -losgDB -losgGA -losgViewer -losgUtil -lOpenThreads');

% For mac clang
%
% make('all','-v CXXFLAGS=''$CXXFLAGS -stdlib=libc++ -std=gnu++11''','-I/usr/local/include -L/usr/local/lib -lc++ -losg -losgViewer -losgDB -losgGA -losgUtil -lOpenThreads -lOpenThreads');

if ismac
  if verLessThan('matlab', '8.0.1')
    system('rm bin/Renderer_.mexmaci64');
    make(DEBUG_FLAG,'-I/usr/local/include -L/usr/local/lib -losg -losgViewer -losgDB -losgGA -losgUtil -lOpenThreads');
  else
    system('rm bin/Renderer_.mexmaci64');
    make(DEBUG_FLAG,'-v CXXFLAGS=''$CXXFLAGS -stdlib=libc++ -std=gnu++11''','-I/usr/local/include -L/usr/local/lib -lc++ -losg -losgViewer -losgDB -losgGA -losgUtil -lOpenThreads');
  end
end
