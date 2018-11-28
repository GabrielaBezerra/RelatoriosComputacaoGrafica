function retval = rotation (angle)
  retval = [cos(angle), -sin(angle); sin(angle), cos(angle)];
endfunction