Skip to content
Search or jump to…
Pull requests
Issues
Marketplace
Explore
 
@JohnFabila 
JohnFabila
/
PEG
Public
Code
Issues
Pull requests
Actions
Projects
Wiki
Security
Insights
Settings
PEG/MIX/Grid2D8nei.m
@JohnFabila
JohnFabila Add files via upload
Latest commit ba1baa0 4 hours ago
 History
 1 contributor
16 lines (11 sloc)  644 Bytes
   
function [adj]=Grid2D8nei(r,c)
diagVec1 = repmat([ones(c-1, 1); 0], r, 1);  
                                             
diagVec1 = diagVec1(1:end-1);                
diagVec2 = [0; diagVec1(1:(c*(r-1)))];       
                                             
diagVec3 = ones(c*(r-1), 1);                 
                                             
diagVec4 = diagVec2(2:end-1);                
                                             
adj = diag(diagVec1, 1)+...                  
      diag(diagVec2, c-1)+...
      diag(diagVec3, c)+...
      diag(diagVec4, c+1);
adj = adj+adj.';                             
                      
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
Loading complete
