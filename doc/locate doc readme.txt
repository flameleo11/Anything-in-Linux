        6.仅显示系统中存在的文件
						当您具有更新的mlocate数据库**时，locate命令仍然会生成文件的结果，这些文件的物理副本已从系统中删除。

						为避免在打孔命令时看到机器中不存在的文件的结果，您将需要使用locate-e命令。该过程会搜索您的系统以验证您要查找的文件是否存在，即使该文件仍存在于mlocate.db中。

						$查找-i -e * text.txt *

						/home/tecmint/text.txt    


7.单独的输出条目，无需换行
定位命令的默认分隔符是换行符(\\n)。但是，如果您更喜欢使用ASCII NUL之类的其他分隔符，则可以使用-0命令行选项。

$查找-i -0 * text.txt *

/home/tecmint/TEXT.txt/home/tecmint/text.txt


        9.抑制定位中的错误消息
不断尝试访问您的定位数据库有时会产生不必要的错误消息，指出您没有对mlocate.db进行根访问的所需特权，因为您只是普通用户，而不是必需的超级用户。

要完全消除这些消息，请使用-q命令。

$找到“ \ *。dat” -q *

10.选择其他位置
如果要输入查询以查找默认mlocate数据库中不存在的结果，并且需要系统其他位置的mlocate.db的答案，则可以将locate命令指向系统其他部分的其他mlocate数据库与-d命令。

$ locate -d <新数据库路径> <文件名>
定位命令可能看起来像是其中一种实用程序，它可以毫不费力地完成您要求的所有操作，但实际上，为了保持进程的效率，需要不时向mlocate.db提供信息。 。否则可能会使程序变得毫无用处。



https://www.tecmint.com/linux-locate-command-practical-examples/
                         
              -b，-basename仅匹配路径名的基本名称             
         -d，--database DBPATH使用DBPATH代替默认数据库（                 
                         
                         
                         
                         
 -i，--ignore-case匹配模式时忽略大小写区别
  -p，--ignore-spaces匹配模式时忽略标点和空格
       -r，-regexp REGEXP搜索基本的regexp REGEXP而不是模式
      --regex模式是扩展的正则表达式        
        -w，--wholename匹配整个路径名（默认）     \\
        
       $ locate -c [tecmint]*

1550          
  
  \
  
  
  
  
  
  
  
  
  -A, --all              only print entries that match all patterns
  -b, --basename         match only the base name of path names
  -c, --count            only print number of found entries
  -d, --database DBPATH  use DBPATH instead of default database (which is
                         /var/lib/mlocate/mlocate.db)
  -e, --existing         only print entries for currently existing files
  -L, --follow           follow trailing symbolic links when checking file
                         existence (default)
                              
  -h, --help             print this help
  -i, --ignore-case      ignore case distinctions when matching patterns
  -p, --ignore-spaces    ignore punctuation and spaces when matching patterns
  -t, --transliterate    ignore accents using iconv transliteration when
                         matching patterns
  -l, --limit, -n LIMIT  limit output (or counting) to LIMIT entries
  -m, --mmap             ignored, for backward compatibility
  -P, --nofollow, -H     don't follow trailing symbolic links when checking file
                         existence
  -0, --null             separate entries with NUL on output
  -S, --statistics       don't search for entries, print statistics about each
     
     
     
                         used database
  -q, --quiet            report no error messages about reading databases
  -r, --regexp REGEXP    search for basic regexp REGEXP instead of patterns
      --regex            patterns are extended regexps
  -s, --stdio            ignored, for backward compatibility
  -V, --version          print version information
  -w, --wholename        match whole path name (default)

