disp('These are the available signals to read and process:')
disp('1) Borre_DiscreteComponents')
disp('2) TEXBAT_cleanStatic')
disp('3) TEXBAT_ds3')
prompt='Choose the signal by entering the number: ';
signal_file1=input(prompt)
signal_file='Borre_DiscreteComponents';
switch signal_file
    case 'Borre_DiscreteComponents'
        a=3
        b=4
    case 'TEXBAT_cleanStatic'
    case 'TEXBAT_ds3'
    otherwise
        disp('error')
end