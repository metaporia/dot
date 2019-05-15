function fish_title
    pwd | sed "s;/home/$USER;~;"
end 
