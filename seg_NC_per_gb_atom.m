clc;                            % Clear screen

clear;                          % Clear memory

tot = 343980;                   % total number of atoms in the simulation box

at_per = 0.06;                     % atomic weight percentage

seg_at = tot * at_per             % total number of segregated atoms

%==================================Open a text file=====================================%

fileID = fopen('dump.Cu_crystal_3d_s_dump_new0.gb','r');                 % name of data file r means read     

formatSpec = '%d %d %f %f %f %d %f';                                        % %d print an integer, %f print a float no.

sizeA = [7 Inf];                                                            % 7 to infinity  

A = fscanf(fileID,formatSpec,sizeA);                                        % reads the number of values specified by size. 

B = A';                                                                     % transpose of matrix A = B  

AUK = B(:,6);                   % Sixth column (aukland)

C_sym = B(:,7);                 % 7th column (centro-symmetry)

AT = B(:,2);                    % Second column (atom type)

not = sum(AUK~=2);              % find out the total number of atoms not equal to 2


%=========================================================================%

%for i = 1:tot   %1 to total no. of atom
    
    %if AUK(i) ~= 2 %if AUK is not equal to two then read all value of AT = 0 
        
        %AT(i) = 0; 
        
    %end
    
    
%end

%for i = 1: tot
    
    %if C_sym (i) >= 8.2 && C_sym (i) <= 8.3 && C_sym (i) <= 8.2938 && C_sym (i) <= 8.27
    
    %if AUK(i) == 0
        
        %AT(i) = 5;
        
    %end
    
%end

total = sum (AUK == 0);


M = find(AUK==0);                        % Find all the atom type with value zero

numelements = round(seg_at);                 % No. of segregated atoms (round means whole no.eg. 5.4 = 5)

indices = randperm(length(M));          % Randperm is used to randomly selct the values from AT

indices = indices(1:numelements);       % Number of elements are chosen 

b = M(indices);                         % no. of indeces selected in the matrix M to assign to matrix b 

AT(b) = 5;                              %corresponding value of b in AT matrix is assign to 5           

idx = M(M==5);                          % to find the position of 5 in matrix M

AT(AT==5) = 5;                          % Number of elements chosen are converted into 2 (2nd atom type)


for i = 1:tot                           % 1 to total no. of atom
    
    if AT(i)== 5                         % if atom type is equal to zero then
       
        AT(i) = 5;                      % atom type is assign 1
                
    end
    
end

B(:,2) = AT;                            % replace second coloum of matrix B with Aton type 

Z=B';                                   % Transpose matrix B = Z


fnickel=fopen('read_data_NC_Mg_H6','w');                     % Convert the matrix into txt file
fprintf(fnickel,'\n %d %d %f %f %f %d %d \r',[Z]);                % Print the matrix in txt file
