FasdUAS 1.101.10   ��   ��    k             i         I     ������
�� .aevtoappnull  �   � ****��  ��    k    � 	 	  
  
 l     ��  ��      select System Snapshot     �   .   s e l e c t   S y s t e m   S n a p s h o t      r         n         1   
 ��
�� 
psxp  l    
 ����  I    
���� 
�� .sysostdfalis    ��� null��    �� ��
�� 
dflc  4    �� 
�� 
psxf  m       �   n / U s e r s / J C / L i b r a r y / L o g s / D i s c i p l i n e / L o g / S y s t e m _ S n a p s h o t s /��  ��  ��    o      ���� 0 
chosenfile 
chosenFile      l   ��������  ��  ��        Z    -   ����  >    ! " ! l    #���� # I   �� $��
�� .corecnte****       **** $ n     % & % 2    ��
�� 
cha  & o    ���� 0 
chosenfile 
chosenFile��  ��  ��   " m    ���� �   k    ) ' '  ( ) ( I   &�� * +
�� .sysodlogaskr        TEXT * m     , , � - - � U m .   P l e a s e   c h o o s e   a   S y s t e m   S n a p s h o t   f i l e   t h a t   i s   i n   t h e   f o l d e r   i t   s h o u l d   b e   i n . . . + �� . /
�� 
btns . J      0 0  1�� 1 m     2 2 � 3 3  O K��   / �� 4��
�� 
dflt 4 m   ! "���� ��   )  5�� 5 L   ' )����  ��  ��  ��     6 7 6 l  . .��������  ��  ��   7  8 9 8 l  . .�� : ;��   :   make file to write to    ; � < < ,   m a k e   f i l e   t o   w r i t e   t o 9  = > = r   . 7 ? @ ? I   . 3�������� 0 makewritefile makeWriteFile��  ��   @ o      ���� 0 	writefile 	writeFile >  A B A I  8 o�� C D
�� .rdwrwritnull���     **** C l  8 _ E���� E b   8 _ F G F b   8 [ H I H b   8 W J K J b   8 C L M L b   8 ? N O N m   8 ; P P � Q Q   S y s t e m   S n a p s h o t : O 1   ; >��
�� 
tab  M 1   ? B��
�� 
tab  K l  C V R���� R c   C V S T S l  C R U���� U n   C R V W V 7  D R�� X Y
�� 
cha  X m   H L���� d Y m   M Q���� v W o   C D���� 0 
chosenfile 
chosenFile��  ��   T m   R U��
�� 
TEXT��  ��   I o   W Z��
�� 
ret  G o   [ ^��
�� 
ret ��  ��   D �� Z [
�� 
refn Z o   b e���� 0 	writefile 	writeFile [ �� \��
�� 
wrat \ m   h k��
�� rdwreof ��   B  ] ^ ] l  p p��������  ��  ��   ^  _ ` _ l  p p�� a b��   a   make master variables    b � c c ,   m a k e   m a s t e r   v a r i a b l e s `  d e d r   p v f g f J   p r����   g o      ���� 0 optallmaster optAllMaster e  h i h r   w } j k j J   w y����   k o      ����  0 optonscrmaster optOnScrMaster i  l m l l  ~ ~��������  ��  ��   m  n o n O   ~ p q p k   � r r  s t s l  � ���������  ��  ��   t  u v u l  � ��� w x��   w   read in pList data    x � y y &   r e a d   i n   p L i s t   d a t a v  z { z r   � � | } | l  � � ~���� ~ n   � �  �  1   � ���
�� 
pcnt � 4   � ��� �
�� 
plif � o   � ����� 0 
chosenfile 
chosenFile��  ��   } o      ���� 0 thedata theData {  ��� � O   � � � � k   �  � �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � #  make list of OptionAll items    � � � � :   m a k e   l i s t   o f   O p t i o n A l l   i t e m s �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
valL � n   � � � � � 2  � ���
�� 
plii � n   � � � � � 4   � ��� �
�� 
plii � m   � �����  � 4   � ��� �
�� 
plii � m   � �����  � o      ���� 0 
optalllist 
optAllList �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � , & make list of OptionOnScreenOnly items    � � � � L   m a k e   l i s t   o f   O p t i o n O n S c r e e n O n l y   i t e m s �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
valL � n   � � � � � 2  � ���
�� 
plii � n   � � � � � 4   � ��� �
�� 
plii � m   � �����  � 4   � ��� �
�� 
plii � m   � �����  � o      ���� "0 optonscreenlist optOnScreenList �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � } w make list of information interested in: {{kCGWindowOwnerName, kCGWindowOwnerPID, kCGWindowNumber, kCGWIndowName}, ...}    � � � � �   m a k e   l i s t   o f   i n f o r m a t i o n   i n t e r e s t e d   i n :   { { k C G W i n d o w O w n e r N a m e ,   k C G W i n d o w O w n e r P I D ,   k C G W i n d o w N u m b e r ,   k C G W I n d o w N a m e } ,   . . . } �  � � � r   � � � � � J   � �����   � o      ���� $0 optallmasteritem optAllMasterItem �  � � � r   � � � � � J   � �����   � o      ���� (0 optonscrmasteritem optOnScrMasterItem �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   for OptionAll    � � � �    f o r   O p t i o n A l l �  � � � Y   �m ��� � ��� � k   �h � �  � � � r   �
 � � � n   � � � � 1  ��
�� 
valL � n   � � � � 4   ��� �
�� 
plii � m   � � � � � � $ k C G W i n d o w O w n e r N a m e � n   � � � � � 4   � ��� �
�� 
plii � o   � ����� 0 i   � n   � � � � � 4   � ��� �
�� 
plii � m   � �����  � 4   � ��� �
�� 
plii � m   � ���  � o      �~�~ 0 
winownname 
winOwnName �  � � � r  * � � � n  & � � � 1  "&�}
�} 
valL � n  " � � � 4  "�| �
�| 
plii � m  ! � � � � � " k C G W i n d o w O w n e r P I D � n   � � � 4  �{ �
�{ 
plii � o  �z�z 0 i   � n   � � � 4  �y �
�y 
plii � m  �x�x  � 4  �w �
�w 
plii � m  �v�v  � o      �u�u 0 	winownpid 	winOwnPID �  � � � r  +J � � � n  +F � � � 1  BF�t
�t 
valL � n  +B � � � 4  ;B�s �
�s 
plii � m  >A � � � � �  k C G W i n d o w N u m b e r � n  +; � � � 4  6;�r �
�r 
plii � o  9:�q�q 0 i   � n  +6 � � � 4  16�p �
�p 
plii � m  45�o�o  � 4  +1�n �
�n 
plii � m  /0�m�m  � o      �l�l 0 winnum winNum �  � � � r  KZ   J  KV  o  KN�k�k 0 
winownname 
winOwnName  o  NQ�j�j 0 	winownpid 	winOwnPID �i o  QT�h�h 0 winnum winNum�i   o      �g�g $0 optallmasteritem optAllMasterItem � �f r  [h	
	 b  [d o  [^�e�e 0 optallmaster optAllMaster J  ^c �d o  ^a�c�c $0 optallmasteritem optAllMasterItem�d  
 o      �b�b 0 optallmaster optAllMaster�f  �� 0 i   � m   � ��a�a  � l  � ��`�_ I  � ��^�]
�^ .corecnte****       **** o   � ��\�\ 0 
optalllist 
optAllList�]  �`  �_  ��   �  l nn�[�Z�Y�[  �Z  �Y    l nn�X�X     for OptionOnScreenOnly    � .   f o r   O p t i o n O n S c r e e n O n l y �W Y  n �V�U k  ~�  r  ~�  n  ~�!"! 1  ���T
�T 
valL" n  ~�#$# 4  ���S%
�S 
plii% m  ��&& �'' $ k C G W i n d o w O w n e r N a m e$ n  ~�()( 4  ���R*
�R 
plii* o  ���Q�Q 0 i  ) n  ~�+,+ 4  ���P-
�P 
plii- m  ���O�O , 4  ~��N.
�N 
plii. m  ���M�M   o      �L�L 0 
winownname 
winOwnName /0/ r  ��121 n  ��343 1  ���K
�K 
valL4 n  ��565 4  ���J7
�J 
plii7 m  ��88 �99 " k C G W i n d o w O w n e r P I D6 n  ��:;: 4  ���I<
�I 
plii< o  ���H�H 0 i  ; n  ��=>= 4  ���G?
�G 
plii? m  ���F�F > 4  ���E@
�E 
plii@ m  ���D�D 2 o      �C�C 0 	winownpid 	winOwnPID0 ABA r  ��CDC n  ��EFE 1  ���B
�B 
valLF n  ��GHG 4  ���AI
�A 
pliiI m  ��JJ �KK  k C G W i n d o w N u m b e rH n  ��LML 4  ���@N
�@ 
pliiN o  ���?�? 0 i  M n  ��OPO 4  ���>Q
�> 
pliiQ m  ���=�= P 4  ���<R
�< 
pliiR m  ���;�; D o      �:�: 0 winnum winNumB STS r  ��UVU J  ��WW XYX o  ���9�9 0 
winownname 
winOwnNameY Z[Z o  ���8�8 0 	winownpid 	winOwnPID[ \�7\ o  ���6�6 0 winnum winNum�7  V o      �5�5 (0 optonscrmasteritem optOnScrMasterItemT ]�4] r  ��^_^ b  ��`a` o  ���3�3  0 optonscrmaster optOnScrMastera J  ��bb c�2c o  ���1�1 (0 optonscrmasteritem optOnScrMasterItem�2  _ o      �0�0  0 optonscrmaster optOnScrMaster�4  �V 0 i   m  qr�/�/  l ryd�.�-d I ry�,e�+
�, .corecnte****       ****e o  ru�*�* "0 optonscreenlist optOnScreenList�+  �.  �-  �U  �W   � n   � �fgf 1   � ��)
�) 
pcntg o   � ��(�( 0 thedata theData��   q m   ~ �hh�                                                                                  sevs   alis    �  Macintosh HD               �a�H+     tSystem Events.app                                                ����        ����  	                CoreServices    �bu      ��C       t   0   /  :Macintosh HD:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   o iji l �'�&�%�'  �&  �%  j klk l �$mn�$  m   checks various stuff   n �oo *   c h e c k s   v a r i o u s   s t u f fl pqp Y  �r�#st�"r k  �uu vwv r  xyx I  �!z� �! *0 getlistofiteminlist getListOfItemInListz {|{ o  �� 0 i  | }�} o  �� 0 optallmaster optAllMaster�  �   y o      �� 0 winall winAllw ~~ r  (��� I  $���� *0 getlistofiteminlist getListOfItemInList� ��� o  �� 0 i  � ��� o   ��  0 optonscrmaster optOnScrMaster�  �  � o      �� 0 winonscr winOnScr ��� r  )8��� I  )4���� <0 checkiflistiscontainedinlist checkIfListIsContainedInList� ��� o  *-�� 0 winonscr winOnScr� ��� o  -0�� 0 winall winAll�  �  � o      �� 0 doescontain doesContain� ��� Z  9������ =  9<��� o  9:�� 0 i  � m  :;�� � k  ?Q�� ��� l ??����  � O I check if OptionAll contains each window owner name of OptionOnScreenOnly   � ��� �   c h e c k   i f   O p t i o n A l l   c o n t a i n s   e a c h   w i n d o w   o w n e r   n a m e   o f   O p t i o n O n S c r e e n O n l y� ��� I  ?Q���
� 20 writeresulttofileforopt writeResultToFileForOpt� ��� o  @C�	�	 0 doescontain doesContain� ��� o  CF�� 0 	writefile 	writeFile� ��� b  FM��� m  FI�� ��� T O p t i o n A l l   c o n t a i n s   e a c h   w i n d o w   o w n e r   n a m e ?� 1  IL�
� 
tab �  �
  �  � ��� =  TW��� o  TU�� 0 i  � m  UV�� � ��� k  Z��� ��� l ZZ����  � N H check if OptionAll contains each window owner PID of OptionOnScreenOnly   � ��� �   c h e c k   i f   O p t i o n A l l   c o n t a i n s   e a c h   w i n d o w   o w n e r   P I D   o f   O p t i o n O n S c r e e n O n l y� ��� I  Zl���� 20 writeresulttofileforopt writeResultToFileForOpt� ��� o  [^� �  0 doescontain doesContain� ��� o  ^a���� 0 	writefile 	writeFile� ���� b  ah��� m  ad�� ��� R O p t i o n A l l   c o n t a i n s   e a c h   w i n d o w   o w n e r   P I D ?� 1  dg��
�� 
tab ��  �  � ��� l mm������  � , & check for duplicate window owner PIDs   � ��� L   c h e c k   f o r   d u p l i c a t e   w i n d o w   o w n e r   P I D s� ��� r  my��� I  mu������� 40 checkforduplicatesinlist checkForDuplicatesInList� ���� o  nq���� 0 winall winAll��  ��  � o      ���� &0 containsduplicate containsDuplicate� ��� I  z�������� 20 writeresulttofileforopt writeResultToFileForOpt� ��� o  {~���� &0 containsduplicate containsDuplicate� ��� o  ~����� 0 	writefile 	writeFile� ���� b  ����� m  ���� ��� \ O p t i o n A l l   h a s   d u p l i c a t e s   o f   w i n d o w   o w n e r   P I D S ?� 1  ����
�� 
tab ��  ��  � ��� r  ����� I  ��������� 40 checkforduplicatesinlist checkForDuplicatesInList� ���� o  ������ 0 winonscr winOnScr��  ��  � o      ���� &0 containsduplicate containsDuplicate� ��� I  ��������� 20 writeresulttofileforopt writeResultToFileForOpt� ��� o  ������ &0 containsduplicate containsDuplicate� ��� o  ������ 0 	writefile 	writeFile� ���� m  ���� ��� n O p t i o n O n S c r e e n O n l y   h a s   d u p l i c a t e s   o f   w i n d o w   o w n e r   P I D s ?��  ��  � ���� l ����������  ��  ��  ��  � ��� =  ����� o  ������ 0 i  � m  ������ � ���� k  ���� ��� l ��������  � K E check if OptionAll contains each window number of OptionOnScreenOnly   � ��� �   c h e c k   i f   O p t i o n A l l   c o n t a i n s   e a c h   w i n d o w   n u m b e r   o f   O p t i o n O n S c r e e n O n l y� ���� I  ��������� 20 writeresulttofileforopt writeResultToFileForOpt� ��� o  ������ 0 doescontain doesContain� ��� o  ������ 0 	writefile 	writeFile� ���� b  ����� b  ����� m  ���� ��� J O p t i o n A l l   c o n t a i n s   e a c h   w i n d o w   n u m b e r� 1  ����
�� 
tab � 1  ����
�� 
tab ��  ��  ��  ��  � I ����� 
�� .rdwrwritnull���     ****� b  �� m  �� �  W T F 1  ����
�� 
tab   ��
�� 
refn o  ������ 0 	writefile 	writeFile ��
�� 
wrat m  ����
�� rdwreof  ��	��
�� 
as  	 m  ����
�� 
TEXT��  � 
��
 l ����������  ��  ��  ��  �# 0 i  s m  ���� t m  ���� �"  q  l ����������  ��  ��    l ������   9 3 associate window owner PIDs and window owner names    � f   a s s o c i a t e   w i n d o w   o w n e r   P I D s   a n d   w i n d o w   o w n e r   n a m e s  r  �  I  �������� *0 getlistofiteminlist getListOfItemInList  m  ������  �� o  ������ 0 optallmaster optAllMaster��  ��   o      ����  0 winownnamesall winOwnNamesAll  r   I  
������ *0 getlistofiteminlist getListOfItemInList   m  ����   !��! o  ���� 0 optallmaster optAllMaster��  ��   o      ���� 0 winownpidsall winOwnPIDsAll "#" r  $%$ J  ����  % o      ���� 0 
winpidlist 
winPIDList# &'& r  ()( J  ����  ) o      ���� 0 winnamelist winNameList' *+* r  ",-, m  ���� - o      ���� 0 	theresult 	theResult+ ./. Y  #�0��12��0 k  3�33 454 r  3?676 n  3;898 4  6;��:
�� 
cobj: o  9:���� 0 i  9 o  36����  0 winownnamesall winOwnNamesAll7 o      ���� 0 theitem theItem5 ;<; r  @L=>= n  @H?@? 4  CH��A
�� 
cobjA o  FG���� 0 i  @ o  @C���� 0 winownpidsall winOwnPIDsAll> o      ���� 0 thenumb theNumb< B��B Z  M�CD��EC H  MUFF E  MTGHG o  MP���� 0 winnamelist winNameListH o  PS���� 0 theitem theItemD k  XsII JKJ r  XeLML b  XaNON o  X[���� 0 winnamelist winNameListO J  [`PP Q��Q o  [^���� 0 theitem theItem��  M o      ���� 0 winnamelist winNameListK R��R r  fsSTS b  foUVU o  fi���� 0 
winpidlist 
winPIDListV J  inWW X��X o  il���� 0 thenumb theNumb��  T o      ���� 0 
winpidlist 
winPIDList��  ��  E k  v�YY Z[Z r  v�\]\ I  v���^���� D0  checkcurrentnameandpidmatchlists  checkCurrentNameAndPIDMatchLists^ _`_ o  wz���� 0 theitem theItem` aba o  z}���� 0 thenumb theNumbb cdc o  }����� 0 winnamelist winNameListd e��e o  ������ 0 
winpidlist 
winPIDList��  ��  ] o      ���� 0 	theresult 	theResult[ f��f Z  ��gh����g =  ��iji o  ������ 0 	theresult 	theResultj m  ������  h  S  ����  ��  ��  ��  �� 0 i  1 m  &'���� 2 l '.k����k I '.��l��
�� .corecnte****       ****l o  '*����  0 winownnamesall winOwnNamesAll��  ��  ��  ��  / mnm I  ����o���� 20 writeresulttofileforopt writeResultToFileForOpto pqp o  ������ 0 	theresult 	theResultq rsr o  ������ 0 	writefile 	writeFiles t��t m  ��uu �vv ` O p t i o n A l l   w i n d o w   o w n e r   n a m e s   a n d   P I D s   a l l   m a t c h ?��  ��  n wxw I  ����y���� "0 writelisttofile writeListToFiley z{z o  ������ 0 winnamelist winNameList{ |�| o  ���~�~ 0 	writefile 	writeFile�  ��  x }~} I  ���}�|�} "0 writelisttofile writeListToFile ��� o  ���{�{ 0 
winpidlist 
winPIDList� ��z� o  ���y�y 0 	writefile 	writeFile�z  �|  ~ ��� l ���x�w�v�x  �w  �v  � ��u� I ���t��
�t .rdwrwritnull���     ****� b  ����� o  ���s
�s 
ret � o  ���r
�r 
ret � �q��
�q 
refn� o  ���p�p 0 	writefile 	writeFile� �o��
�o 
wrat� m  ���n
�n rdwreof � �m��l
�m 
as  � m  ���k
�k 
TEXT�l  �u    ��� l     �j�i�h�j  �i  �h  � ��� l     �g���g  �   -- HELPER FUNCTIONS --   � ��� .   - -   H E L P E R   F U N C T I O N S   - -� ��� l     �f�e�d�f  �e  �d  � ��� l     �c���c  � / ) ========================================   � ��� R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =� ��� i    ��� I      �b��a�b D0  checkcurrentnameandpidmatchlists  checkCurrentNameAndPIDMatchLists� ��� o      �`�` 0 thename theName� ��� o      �_�_ 0 thenumb theNumb� ��� o      �^�^ 0 thenamelist theNameList� ��]� o      �\�\ 0 thenumblist theNumbList�]  �a  � k     C�� ��� r     ��� m     �[�[  � o      �Z�Z 0 returnvalue returnValue� ��� Y    @��Y���X� k    ;�� ��� r    ��� n    ��� 4    �W�
�W 
cobj� o    �V�V 0 i  � o    �U�U 0 thenamelist theNameList� o      �T�T 0 currentname currentName� ��� r    ��� n    ��� 4    �S�
�S 
cobj� o    �R�R 0 i  � o    �Q�Q 0 thenumblist theNumbList� o      �P�P 0 currentnumb currentNumb� ��O� Z     ;���N�M� =    #��� o     !�L�L 0 currentname currentName� o   ! "�K�K 0 thename theName� k   & 7�� ��� Z   & 5���J�� =  & )��� o   & '�I�I 0 currentnumb currentNumb� o   ' (�H�H 0 thenumb theNumb� r   , /��� m   , -�G�G � o      �F�F 0 returnvalue returnValue�J  � r   2 5��� m   2 3�E�E  � o      �D�D 0 returnvalue returnValue� ��C�  S   6 7�C  �N  �M  �O  �Y 0 i  � m    �B�B � I   �A��@
�A .corecnte****       ****� o    	�?�? 0 thenamelist theNameList�@  �X  � ��>� L   A C�� o   A B�=�= 0 returnvalue returnValue�>  � ��� l     �<�;�:�<  �;  �:  � ��� l     �9���9  � / ) ========================================   � ��� R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =� ��� l     �8���8  � 6 0 check if only one copy of each item in thisList   � ��� `   c h e c k   i f   o n l y   o n e   c o p y   o f   e a c h   i t e m   i n   t h i s L i s t� ��� i    ��� I      �7��6�7 40 checkforduplicatesinlist checkForDuplicatesInList� ��5� o      �4�4 0 thislist thisList�5  �6  � k     :�� ��� r     ��� o     �3�3 0 thislist thisList� o      �2�2 0 copythis copyThis� ��� r    ��� m    �1�1  � o      �0�0 "0 duplicateexists duplicateExists� ��� Y    7��/���.� k    2�� ��� r    ��� n    ��� 4    �-�
�- 
cobj� m    �,�, � o    �+�+ 0 copythis copyThis� o      �*�* 0 current  � � � r    " n      1     �)
�) 
rest o    �(�( 0 copythis copyThis o      �'�' 0 therest theRest  �& Z   # 2�%�$ E   # &	 o   # $�#�# 0 therest theRest	 o   $ %�"�" 0 current   k   ) .

  r   ) , m   ) *�!�!  o      � �  "0 duplicateexists duplicateExists �  S   - .�  �%  �$  �&  �/ 0 i  � m    �� � l   �� I   ��
� .corecnte****       **** o    �� 0 thislist thisList�  �  �  �.  � � L   8 : o   8 9�� "0 duplicateexists duplicateExists�  �  l     ����  �  �    l     ��   / ) ========================================    � R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  l     ��   5 / checks if each item in thisList is in thatList    � ^   c h e c k s   i f   e a c h   i t e m   i n   t h i s L i s t   i s   i n   t h a t L i s t  !  i    "#" I      �$�� <0 checkiflistiscontainedinlist checkIfListIsContainedInList$ %&% o      �� 0 thislist thisList& '�' o      �� 0 thatlist thatList�  �  # k     -(( )*) r     +,+ m     �� , o      �� 0 doescontain doesContain* -.- Y    */�
01�	/ Z    %23��2 H    44 E    565 o    �� 0 thatlist thatList6 n    787 4    �9
� 
cobj9 o    �� 0 i  8 o    �� 0 thislist thisList3 k    !:: ;<; r    =>= m    ��  > o      �� 0 doescontain doesContain< ?� ?  S     !�   �  �  �
 0 i  0 m    ���� 1 l   @����@ I   ��A��
�� .corecnte****       ****A o    	���� 0 thislist thisList��  ��  ��  �	  . B��B L   + -CC o   + ,���� 0 doescontain doesContain��  ! DED l     ��FG��  F / ) ========================================   G �HH R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =E IJI l     ��KL��  K 9 3 retrieve specified item based on number from list    L �MM f   r e t r i e v e   s p e c i f i e d   i t e m   b a s e d   o n   n u m b e r   f r o m   l i s t  J NON l     ��PQ��  P 8 2 input list should only be one of the master lists   Q �RR d   i n p u t   l i s t   s h o u l d   o n l y   b e   o n e   o f   t h e   m a s t e r   l i s t sO STS i    UVU I      ��W���� *0 getlistofiteminlist getListOfItemInListW XYX o      ���� 0 itemnum itemNumY Z��Z o      ���� 0 thelist theList��  ��  V k     0[[ \]\ r     ^_^ J     ����  _ o      ���� 0 
returnlist 
returnList] `a` Y    -b��cd��b k    (ee fgf r    hih n    jkj 4    ��l
�� 
cobjl o    ���� 0 i  k o    ���� 0 thelist theListi o      ����  0 listiteminlist listItemInListg mnm r     opo n    qrq 4    ��s
�� 
cobjs o    ���� 0 itemnum itemNumr o    ����  0 listiteminlist listItemInListp o      ���� 0 
returnitem 
returnItemn t��t r   ! (uvu b   ! &wxw o   ! "���� 0 
returnlist 
returnListx J   " %yy z��z o   " #���� 0 
returnitem 
returnItem��  v o      ���� 0 
returnlist 
returnList��  �� 0 i  c m    	���� d l  	 {����{ I  	 ��|��
�� .corecnte****       ****| o   	 
���� 0 thelist theList��  ��  ��  ��  a }��} L   . 0~~ o   . /���� 0 
returnlist 
returnList��  T � l     ��������  ��  ��  � ��� l     ������  � / ) ========================================   � ��� R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =� ��� i    ��� I      �������� 0 makewritefile makeWriteFile��  ��  � k     1�� ��� r     ��� 4     ���
�� 
psxf� m    �� ��� < / U s e r s / J C / D e s k t o p / b a s e b a l l . t x t� o      ���� 0 filetoreturn fileToReturn� ��� Q     ���� r   
 ��� I  
 ����
�� .rdwropenshor       file� o   
 ���� 0 filetoreturn fileToReturn� �����
�� 
perm� m    ��
�� boovtrue��  � o      ���� 0 filetoreturn fileToReturn� R      ����
�� .ascrerr ****      � ****� o      ���� 0 errmsg errMsg� �����
�� 
errn� o      ���� 0 errornumber errorNumber��  � k     �� ��� l   ������  � g a		display dialog ("An unknown error occurred: " & errorNumber as text) & return & return & errMsg   � ��� � 	 	 d i s p l a y   d i a l o g   ( " A n   u n k n o w n   e r r o r   o c c u r r e d :   "   &   e r r o r N u m b e r   a s   t e x t )   &   r e t u r n   &   r e t u r n   &   e r r M s g� ���� I    �����
�� .rdwrclosnull���     ****� o    ���� 0 filetoreturn fileToReturn��  ��  � ��� I  ! .����
�� .rdwrwritnull���     ****� b   ! $��� m   ! "�� ��� P = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =� o   " #��
�� 
ret � ����
�� 
refn� o   % &���� 0 filetoreturn fileToReturn� ����
�� 
wrat� m   ' (��
�� rdwreof � �����
�� 
as  � m   ) *��
�� 
TEXT��  � ���� L   / 1�� o   / 0���� 0 filetoreturn fileToReturn��  � ��� l     ��������  ��  ��  � ��� l     ������  � / ) ========================================   � ��� R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =� ��� i    ��� I      ������� "0 writelisttofile writeListToFile� ��� o      ���� 0 thelist theList� ���� o      ���� 0 thefile theFile��  ��  � k     >�� ��� Y     '�������� I   "����
�� .rdwrwritnull���     ****� b    ��� l   ������ c    ��� n    ��� 4    ���
�� 
cobj� o    ���� 0 i  � o    ���� 0 thelist theList� m    ��
�� 
TEXT��  ��  � m    �� ���  ,  � ����
�� 
refn� o    ���� 0 thefile theFile� ����
�� 
wrat� m    ��
�� rdwreof � �����
�� 
as  � m    ��
�� 
TEXT��  �� 0 i  � m    ���� � l   ������ \    ��� l   	������ I   	�����
�� .corecnte****       ****� o    ���� 0 thelist theList��  ��  ��  � m   	 
���� ��  ��  ��  � ���� I  ( >����
�� .rdwrwritnull���     ****� b   ( 4��� n   ( 2��� 4   + 2���
�� 
cobj� l  , 1������ I  , 1�����
�� .corecnte****       ****� o   , -���� 0 thelist theList��  ��  ��  � l  ( +������ c   ( +��� o   ( )���� 0 thelist theList� m   ) *��
�� 
TEXT��  ��  � o   2 3��
�� 
ret � ����
�� 
refn� o   5 6���� 0 thefile theFile� ����
�� 
wrat� m   7 8��
�� rdwreof � ���~
� 
as  � m   9 :�}
�} 
TEXT�~  ��  � ��� l     �|�{�z�|  �{  �z  � ��� l     �y���y  � / ) ========================================   � ��� R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =� ��� i    ��� I      �x��w�x 20 writeresulttofileforopt writeResultToFileForOpt� � � 1      �v
�v 
rslt   o      �u�u 0 thefile theFile �t o      �s�s 0 opt  �t  �w  � k     1  I    �r
�r .rdwrwritnull���     **** b     	
	 o     �q�q 0 opt  
 1    �p
�p 
tab  �o
�o 
refn o    �n�n 0 thefile theFile �m
�m 
wrat m    �l
�l rdwreof  �k�j
�k 
as   m    	�i
�i 
TEXT�j   �h Z    1�g =     1    �f
�f 
rslt m    �e�e  I   !�d
�d .rdwrwritnull���     **** b     m     �  Y E S o    �c
�c 
ret  �b
�b 
refn o    �a�a 0 thefile theFile �`
�` 
wrat m    �_
�_ rdwreof  �^ �]
�^ 
as    m    �\
�\ 
TEXT�]  �g   I  $ 1�[!"
�[ .rdwrwritnull���     ****! b   $ '#$# m   $ %%% �&&  N O$ o   % &�Z
�Z 
ret " �Y'(
�Y 
refn' o   ( )�X�X 0 thefile theFile( �W)*
�W 
wrat) m   * +�V
�V rdwreof * �U+�T
�U 
as  + m   , -�S
�S 
TEXT�T  �h  � ,-, l     �R�Q�P�R  �Q  �P  - ./. l     �O01�O  0 / ) ========================================   1 �22 R   = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =/ 3�N3 i     #454 I      �M6�L�M 0 writetofile writeToFile6 787 o      �K�K 0 namelist nameList8 9:9 o      �J�J 0 winlist winList: ;�I; o      �H�H 0 filetowriteto fileToWriteTo�I  �L  5 Y     W<�G=>�F< k    R?? @A@ I   �EBC
�E .rdwrwritnull���     ****B b    DED n    FGF 4    �DH
�D 
cobjH o    �C�C 0 i  G o    �B�B 0 namelist nameListE m    II �JJ  :  C �AKL
�A 
refnK o    �@�@ 0 filetowriteto fileToWriteToL �?MN
�? 
wratM m    �>
�> rdwreof N �=O�<
�= 
as  O m    �;
�; 
TEXT�<  A PQP Y    HR�:ST�9R I  0 C�8UV
�8 .rdwrwritnull���     ****U b   0 ;WXW l  0 9Y�7�6Y c   0 9Z[Z n   0 7\]\ 4   4 7�5^
�5 
cobj^ o   5 6�4�4 0 j  ] n   0 4_`_ 4   1 4�3a
�3 
cobja o   2 3�2�2 0 i  ` o   0 1�1�1 0 winlist winList[ m   7 8�0
�0 
TEXT�7  �6  X m   9 :bb �cc  ,  V �/de
�/ 
refnd o   < =�.�. 0 filetowriteto fileToWriteToe �-f�,
�- 
wratf m   > ?�+
�+ rdwreof �,  �: 0 j  S m   " #�*�* T l  # +g�)�(g I  # +�'h�&
�' .corecnte****       ****h n   # 'iji 4   $ '�%k
�% 
cobjk o   % &�$�$ 0 i  j o   # $�#�# 0 winlist winList�&  �)  �(  �9  Q l�"l I  I R�!mn
�! .rdwrwritnull���     ****m o   I J� 
�  
ret n �op
� 
refno o   K L�� 0 filetowriteto fileToWriteTop �q�
� 
wratq m   M N�
� rdwreof �  �"  �G 0 i  = m    �� > I   	�r�
� .corecnte****       ****r o    �� 0 namelist nameList�  �F  �N       &�stuvwxyz{|}�~������������������������  s $�
�	��������� ��������������������������������������������������
�
 .aevtoappnull  �   � ****�	 D0  checkcurrentnameandpidmatchlists  checkCurrentNameAndPIDMatchLists� 40 checkforduplicatesinlist checkForDuplicatesInList� <0 checkiflistiscontainedinlist checkIfListIsContainedInList� *0 getlistofiteminlist getListOfItemInList� 0 makewritefile makeWriteFile� "0 writelisttofile writeListToFile� 20 writeresulttofileforopt writeResultToFileForOpt� 0 writetofile writeToFile� 0 
chosenfile 
chosenFile�  0 	writefile 	writeFile�� 0 optallmaster optAllMaster��  0 optonscrmaster optOnScrMaster�� 0 thedata theData�� 0 
optalllist 
optAllList�� "0 optonscreenlist optOnScreenList�� $0 optallmasteritem optAllMasterItem�� (0 optonscrmasteritem optOnScrMasterItem�� 0 
winownname 
winOwnName�� 0 	winownpid 	winOwnPID�� 0 winnum winNum�� 0 winall winAll�� 0 winonscr winOnScr�� 0 doescontain doesContain�� &0 containsduplicate containsDuplicate��  0 winownnamesall winOwnNamesAll�� 0 winownpidsall winOwnPIDsAll�� 0 
winpidlist 
winPIDList�� 0 winnamelist winNameList�� 0 	theresult 	theResult�� 0 theitem theItem�� 0 thenumb theNumb��  ��  ��  ��  t �� ��������
�� .aevtoappnull  �   � ****��  ��  � ���� 0 i  � K���� ������������ ,�� 2���������� P����������������������h������������������ ��� ��� ���&8J�������������������������������������������u��
�� 
dflc
�� 
psxf
�� .sysostdfalis    ��� null
�� 
psxp�� 0 
chosenfile 
chosenFile
�� 
cha 
�� .corecnte****       ****�� �
�� 
btns
�� 
dflt�� 
�� .sysodlogaskr        TEXT�� 0 makewritefile makeWriteFile�� 0 	writefile 	writeFile
�� 
tab �� d�� v
�� 
TEXT
�� 
ret 
�� 
refn
�� 
wrat
�� rdwreof 
�� .rdwrwritnull���     ****�� 0 optallmaster optAllMaster��  0 optonscrmaster optOnScrMaster
�� 
plif
�� 
pcnt�� 0 thedata theData
�� 
plii
�� 
valL�� 0 
optalllist 
optAllList�� "0 optonscreenlist optOnScreenList�� $0 optallmasteritem optAllMasterItem�� (0 optonscrmasteritem optOnScrMasterItem�� 0 
winownname 
winOwnName�� 0 	winownpid 	winOwnPID�� 0 winnum winNum�� *0 getlistofiteminlist getListOfItemInList�� 0 winall winAll�� 0 winonscr winOnScr�� <0 checkiflistiscontainedinlist checkIfListIsContainedInList�� 0 doescontain doesContain�� 20 writeresulttofileforopt writeResultToFileForOpt�� 40 checkforduplicatesinlist checkForDuplicatesInList�� &0 containsduplicate containsDuplicate
�� 
as  �� ��  0 winownnamesall winOwnNamesAll�� 0 winownpidsall winOwnPIDsAll�� 0 
winpidlist 
winPIDList�� 0 winnamelist winNameList�� 0 	theresult 	theResult
�� 
cobj�� 0 theitem theItem�� 0 thenumb theNumb�� D0  checkcurrentnameandpidmatchlists  checkCurrentNameAndPIDMatchLists�� "0 writelisttofile writeListToFile���*�)��/l �,E�O��-j � ���kv�k� OhY hO*j+ E` Oa _ %_ %�[�\[Za \Za 2a &%_ %_ %a _ a a � OjvE` OjvE` Oa *a �/a ,E`  O_  a ,e*a !k/a !k/a !-a ",E` #O*a !l/a !k/a !-a ",E` $OjvE` %OjvE` &O �k_ #j kh  *a !k/a !k/a !�/a !a '/a ",E` (O*a !k/a !k/a !�/a !a )/a ",E` *O*a !k/a !k/a !�/a !a +/a ",E` ,O_ (_ *_ ,mvE` %O_ _ %kv%E` [OY�}O �k_ $j kh  *a !l/a !k/a !�/a !a -/a ",E` (O*a !l/a !k/a !�/a !a ./a ",E` *O*a !l/a !k/a !�/a !a //a ",E` ,O_ (_ *_ ,mvE` &O_ _ &kv%E` [OY�}UUO �kmkh  *�_ l+ 0E` 1O*�_ l+ 0E` 2O*_ 2_ 1l+ 3E` 4O�k  *_ 4_ a 5_ %m+ 6Y ��l  U*_ 4_ a 7_ %m+ 6O*_ 1k+ 8E` 9O*_ 9_ a :_ %m+ 6O*_ 2k+ 8E` 9O*_ 9_ a ;m+ 6OPY @�m  *_ 4_ a <_ %_ %m+ 6Y !a =_ %a _ a a a >a a ? OP[OY�O*k_ l+ 0E` @O*l_ l+ 0E` AOjvE` BOjvE` COkE` DO zk_ @j kh  _ @a E�/E` FO_ Aa E�/E` GO_ C_ F  _ C_ Fkv%E` CO_ B_ Gkv%E` BY %*_ F_ G_ C_ B�+ HE` DO_ Dj  Y h[OY��O*_ D_ a Im+ 6O*_ C_ l+ JO*_ B_ l+ JO_ _ %a _ a a a >a a ? u ������������� D0  checkcurrentnameandpidmatchlists  checkCurrentNameAndPIDMatchLists�� ����� �  ���������� 0 thename theName�� 0 thenumb theNumb�� 0 thenamelist theNameList�� 0 thenumblist theNumbList��  � ������������������ 0 thename theName�� 0 thenumb theNumb�� 0 thenamelist theNameList�� 0 thenumblist theNumbList�� 0 returnvalue returnValue�� 0 i  �� 0 currentname currentName�� 0 currentnumb currentNumb� ����
�� .corecnte****       ****
�� 
cobj�� DjE�O ;k�j  kh ��/E�O��/E�O��  ��  kE�Y jE�OY h[OY��O�v ������������� 40 checkforduplicatesinlist checkForDuplicatesInList�� ����� �  ���� 0 thislist thisList��  � �������������� 0 thislist thisList�� 0 copythis copyThis�� "0 duplicateexists duplicateExists�� 0 i  �� 0 current  �� 0 therest theRest� ������
�� .corecnte****       ****
�� 
cobj
�� 
rest�� ;�E�OjE�O .k�j  kh ��k/E�O��,E�O�� 
kE�OY h[OY��O�w ��#���������� <0 checkiflistiscontainedinlist checkIfListIsContainedInList�� ����� �  ������ 0 thislist thisList�� 0 thatlist thatList��  � ��~�}�|� 0 thislist thisList�~ 0 thatlist thatList�} 0 doescontain doesContain�| 0 i  � �{�z
�{ .corecnte****       ****
�z 
cobj�� .kE�O %k�j  kh ���/ 
jE�OY h[OY��O�x �yV�x�w���v�y *0 getlistofiteminlist getListOfItemInList�x �u��u �  �t�s�t 0 itemnum itemNum�s 0 thelist theList�w  � �r�q�p�o�n�m�r 0 itemnum itemNum�q 0 thelist theList�p 0 
returnlist 
returnList�o 0 i  �n  0 listiteminlist listItemInList�m 0 
returnitem 
returnItem� �l�k
�l .corecnte****       ****
�k 
cobj�v 1jvE�O 'k�j  kh ��/E�O��/E�O��kv%E�[OY��O�y �j��i�h���g�j 0 makewritefile makeWriteFile�i  �h  � �f�e�d�f 0 filetoreturn fileToReturn�e 0 errmsg errMsg�d 0 errornumber errorNumber� �c��b�a�`��_��^�]�\�[�Z�Y�X�W
�c 
psxf
�b 
perm
�a .rdwropenshor       file�` 0 errmsg errMsg� �V�U�T
�V 
errn�U 0 errornumber errorNumber�T  
�_ .rdwrclosnull���     ****
�^ 
ret 
�] 
refn
�\ 
wrat
�[ rdwreof 
�Z 
as  
�Y 
TEXT�X 
�W .rdwrwritnull���     ****�g 2)��/E�O ��el E�W X  �j O��%������ O�z �S��R�Q���P�S "0 writelisttofile writeListToFile�R �O��O �  �N�M�N 0 thelist theList�M 0 thefile theFile�Q  � �L�K�J�L 0 thelist theList�K 0 thefile theFile�J 0 i  � �I�H�G��F�E�D�C�B�A�@
�I .corecnte****       ****
�H 
cobj
�G 
TEXT
�F 
refn
�E 
wrat
�D rdwreof 
�C 
as  �B 
�A .rdwrwritnull���     ****
�@ 
ret �P ? &k�j  kkh ��/�&�%������ 	[OY��O��&�j  /�%������ 	{ �?��>�=���<�? 20 writeresulttofileforopt writeResultToFileForOpt�> �;��; �  �:�9�8
�: 
rslt�9 0 thefile theFile�8 0 opt  �=  � �7�6�5
�7 
rslt�6 0 thefile theFile�5 0 opt  � �4�3�2�1�0�/�.�-�,%
�4 
tab 
�3 
refn
�2 
wrat
�1 rdwreof 
�0 
as  
�/ 
TEXT�. 
�- .rdwrwritnull���     ****
�, 
ret �< 2��%������ O�k  ��%������ Y ��%������ | �+5�*�)���(�+ 0 writetofile writeToFile�* �'��' �  �&�%�$�& 0 namelist nameList�% 0 winlist winList�$ 0 filetowriteto fileToWriteTo�)  � �#�"�!� ��# 0 namelist nameList�" 0 winlist winList�! 0 filetowriteto fileToWriteTo�  0 i  � 0 j  � ��I�������b��
� .corecnte****       ****
� 
cobj
� 
refn
� 
wrat
� rdwreof 
� 
as  
� 
TEXT� 
� .rdwrwritnull���     ****� 
� 
ret �( X Vk�j  kh ��/�%������ 	O (k��/j  kh ��/�/�&�%���� 	[OY��O����� 	[OY��} ��� / U s e r s / J C / L i b r a r y / L o g s / D i s c i p l i n e / L o g / S y s t e m _ S n a p s h o t s / S y s t e m _ S n a p s h o t s _ 2 0 0 9 - 0 5 - 2 1 / S y s t e m _ S n a p s h o t _ 2 0 0 9 - 0 5 - 2 1   1 8 : 1 2 : 3 9   - 0 5 0 0 . p l i s t�	�~ ��� #� # ������������������������������������ ��� �  ���� ��� 
 X c o d e���!R� ��� �  ���� ��� 
 X c o d e���!D� ��� �  ���
� ��� 
 X c o d e���
!4� �	��	 �  ���� ��� 
 X c o d e���!3� ��� �  ���� ��� 
 X c o d e���!.� ��� �  ���� ��� 
 X c o d e���!-� � ��  �  ������ ��� 
 X c o d e�����!*� ����� �  ������ ��� 
 X c o d e�����!)� ����� �  ������ ��� 
 X c o d e�����!'� ����� �  ������ ��� 
 X c o d e�����!$� ����� �  ������ ��� 
 X c o d e�����!#� ����� �  ������ ��� 
 X c o d e�����! � ����� �  ������ ��� 
 X c o d e�����!� ����� �  ������ ���  S a f a r i������� ����� �  ������ ���  S c r i p t   E d i t o r�� ���A� ����� �  ������ ���  S k i m�����}� ����� �  ������ ���  S k i m�����|� ����� �  ������ ���  S k i m�����{� �� ��    ���� �  S k i m�����x� ����   ���� �  S k i m�����w� ����   ���� �  S k i m�����v� ��	�� 	  
����
 �  S k i m�����u� ����   ���� �  S a f a r i������� ����   ���� �  S a f a r i�����E� ����   ���� �  S a f a r i������� ����   ���� �  S a f a r i������� ����   ���� �  S a f a r i������� ����   ���� �  M a i l�����	� ����   ���� �    M a i l������� ��!�� !  "����" �##  S c r i p t   E d i t o r�� ����� ��$�� $  %����% �&&  S c r i p t   E d i t o r�� ����� ��'�� '  (����( �))  S c r i p t   E d i t o r�� ����� ��*�� *  +����+ �,,  D r o p b o x�� ��� �� ��-�� -  .����. �//  D r o p b o x�� ��� ~� ��0�� 0  1����1 �22  C a f f e i n e�� ��� ! ��3�� 	3 	 456789:;�4 ��<�� <  =����= �>>  C a f f e i n e�� ��� !5 ��?�� ?  @����@ �AA  D r o p b o x�� ��� �6 ��B�� B  C����C �DD 
 X c o d e�����!'7 ��E�� E  F����F �GG 
 X c o d e�����!#8 ��H�� H  I����I �JJ 
 X c o d e�����!9 ��K�� K  L����L �MM  S c r i p t   E d i t o r�� ����: ��N�� N  O����O �PP  S k i m�����}; ��Q�� Q  R����R �SS  S a f a r i������� ��T�� T  ������ �UU  M a i l������� VV W��W h��X
�� 
plifX �YY M a c i n t o s h   H D : U s e r s : J C : L i b r a r y : L o g s : D i s c i p l i n e : L o g : S y s t e m _ S n a p s h o t s : S y s t e m _ S n a p s h o t s _ 2 0 0 9 - 0 5 - 2 1 : S y s t e m _ S n a p s h o t _ 2 0 0 9 - 0 5 - 2 1   1 8 / 1 2 / 3 9   - 0 5 0 0 . p l i s t
�� 
pcnt� ��Z�� #Z # [\]^_`abcdefghijklmnopqrstuvwxyz{|}[ ����~�� 0 kCGWindowNumber  ��!R~ ����� 0 kCGWindowAlpha   ?�      � ������ 0 kCGWindowName  � ��� 2 M o i r a e   -   D e b u g g e r   C o n s o l e� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������ 0 kCGWindowMemoryUsage  �  �`� �~���~ 0 kCGWindowBounds  � �}���} 0 X  � @w�     � �|���| 
0 Height  � @|�     � �{���{ 	0 Width  � @��     � �z��y�z 0 Y  � @wp     �y  � �x���x 0 kCGWindowOwnerName  � ��� 
 X c o d e� �w�v�u�w 0 kCGWindowOwnerPID  �v��u  \ �t�s��t 0 kCGWindowNumber  �s!D� �r���r 0 kCGWindowAlpha  � ?�      � �q���q 0 kCGWindowName  � ��� , M o i r a e   -   B u i l d   R e s u l t s� �p�o��p 0 kCGWindowStoreType  �o � �n�m��n 0 kCGWindowSharingState  �m � �l�k��l 0 kCGWindowLayer  �k  � �j�i��j 0 kCGWindowMemoryUsage  �i  �`� �h���h 0 kCGWindowBounds  � �g���g 0 X  � @^@     � �f���f 
0 Height  � @      � �e���e 	0 Width  � @@     � �d��c�d 0 Y  � @F�     �c  � �b���b 0 kCGWindowOwnerName  � ��� 
 X c o d e� �a�`�_�a 0 kCGWindowOwnerPID  �`��_  ] �^�]��^ 0 kCGWindowNumber  �]!4� �\���\ 0 kCGWindowAlpha  � ?�      � �[�Z��[ 0 kCGWindowStoreType  �Z � �Y�X��Y 0 kCGWindowSharingState  �X � �W�V��W 0 kCGWindowLayer  �V  � �U�T��U 0 kCGWindowMemoryUsage  �T#`� �S���S 0 kCGWindowBounds  � �R���R 0 X  �         � �Q���Q 
0 Height  � @0      � �P���P 	0 Width  � @0      � �O��N�O 0 Y  � @��     �N  � �M���M 0 kCGWindowOwnerName  � ��� 
 X c o d e� �L�K�J�L 0 kCGWindowOwnerPID  �K��J  ^ �I�H��I 0 kCGWindowNumber  �H!3� �G���G 0 kCGWindowAlpha  � ?�      � �F�E��F 0 kCGWindowStoreType  �E � �D�C��D 0 kCGWindowSharingState  �C � �B�A��B 0 kCGWindowLayer  �A  � �@�?��@ 0 kCGWindowMemoryUsage  �?  `� �>���> 0 kCGWindowBounds  � �=���= 0 X  �         � �<���< 
0 Height  � @`      � �;���; 	0 Width  � @`      � �:��9�: 0 Y  � @�      �9  � �8���8 0 kCGWindowOwnerName  � ��� 
 X c o d e� �7�6�5�7 0 kCGWindowOwnerPID  �6��5  _ �4�3��4 0 kCGWindowNumber  �3!.� �2���2 0 kCGWindowAlpha  � ?�      � �1���1 0 kCGWindowName  � ��� " M o i r a e   -   D e b u g g e r� �0�/��0 0 kCGWindowStoreType  �/ � �.�-��. 0 kCGWindowSharingState  �- � �,�+��, 0 kCGWindowLayer  �+  � �*�)��* 0 kCGWindowMemoryUsage  �)  .�`� �(���( 0 kCGWindowBounds  � �'���' 0 X  � @f�     � �&���& 
0 Height  � @��     � �%���% 	0 Width  � @��     � �$��#�$ 0 Y  � @7      �#  � �"���" 0 kCGWindowOwnerName  � ��� 
 X c o d e� �!� ��! 0 kCGWindowOwnerPID  � ��  ` ���� 0 kCGWindowNumber  �!-� ���� 0 kCGWindowAlpha  � ?�      � ���� 0 kCGWindowName  � ���   S i n g l e   F i l e   F i n d� ���� 0 kCGWindowStoreType  � � ���� 0 kCGWindowSharingState  � � ���� 0 kCGWindowLayer  �  � ���� 0 kCGWindowMemoryUsage  �   �`� ���� 0 kCGWindowBounds  � ���� 0 X  � @q`     � ���� 
0 Height  � @f�     � ���� 	0 Width  � @�     � ���� 0 Y  � @�     �  � ���� 0 kCGWindowOwnerName  � ��� 
 X c o d e� ��
�	� 0 kCGWindowOwnerPID  �
��	  a ���� 0 kCGWindowNumber  �!*� ���� 0 kCGWindowAlpha  � ?�      � �� � 0 kCGWindowName  � �  C o d e   A s s i s t a n t  ��� 0 kCGWindowStoreType  �  ��� 0 kCGWindowSharingState  �  � ���  0 kCGWindowLayer  �� e ������ 0 kCGWindowMemoryUsage  ��` ���� 0 kCGWindowBounds   ��	�� 0 X   @p�     	 ��
�� 
0 Height  
 @i       ���� 	0 Width   @k�      ������ 0 Y   @|P     ��   ���� 0 kCGWindowOwnerName   � 
 X c o d e �������� 0 kCGWindowOwnerPID  �����  b ������ 0 kCGWindowNumber  ��!) ���� 0 kCGWindowAlpha   ?�       ���� 0 kCGWindowName   �  C o d e   A s s i s t a n t ������ 0 kCGWindowStoreType  ��  ������ 0 kCGWindowSharingState  ��  ������ 0 kCGWindowLayer  �� e ������ 0 kCGWindowMemoryUsage  ��` ���� 0 kCGWindowBounds   ���� 0 X   @p�      �� !�� 
0 Height    @i      ! ��"#�� 	0 Width  " @k�     # ��$���� 0 Y  $ @|P     ��   ��%&�� 0 kCGWindowOwnerName  % �'' 
 X c o d e& �������� 0 kCGWindowOwnerPID  �����  c ����(�� 0 kCGWindowNumber  ��!'( ����)�� 0 kCGWindowOwnerPID  ���) ��*+�� 0 kCGWindowAlpha  * ?�      + ��,-�� 0 kCGWindowName  , �.. * C l o t h o S c r e e n W a t c h e r . m- ����/�� 0 kCGWindowStoreType  �� / ����0�� 0 kCGWindowWorkspace  �� 0 ����1�� 0 kCGWindowSharingState  �� 1 ����2�� 0 kCGWindowLayer  ��  2 ����3�� 0 kCGWindowMemoryUsage  ��  )t\3 ��45�� 0 kCGWindowBounds  4 ��67�� 0 X  6 @�      7 ��89�� 
0 Height  8 @�P     9 ��:;�� 	0 Width  : @�x     ; ��<���� 0 Y  < @6      ��  5 ��=>�� 0 kCGWindowOwnerName  = �?? 
 X c o d e> �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  d ����@�� 0 kCGWindowNumber  ��!$@ ��AB�� 0 kCGWindowAlpha  A ?�      B ����C�� 0 kCGWindowStoreType  �� C ����D�� 0 kCGWindowSharingState  �� D ����E�� 0 kCGWindowLayer  ��  E ����F�� 0 kCGWindowMemoryUsage  ��S`F ��GH�� 0 kCGWindowBounds  G ��IJ�� 0 X  I         J ��KL�� 
0 Height  K @r      L ��MN�� 	0 Width  M @0      N ��O���� 0 Y  O @�      ��  H ��PQ�� 0 kCGWindowOwnerName  P �RR 
 X c o d eQ �������� 0 kCGWindowOwnerPID  �����  e ����S�� 0 kCGWindowNumber  ��!#S ����T�� 0 kCGWindowOwnerPID  ���T ��UV�� 0 kCGWindowAlpha  U ?�      V ��WX�� 0 kCGWindowName  W �YY  C l o t h o L o g g e r . mX ����Z�� 0 kCGWindowStoreType  �� Z ����[�� 0 kCGWindowWorkspace  �� [ ����\�� 0 kCGWindowSharingState  �� \ ����]�� 0 kCGWindowLayer  ��  ] ����^�� 0 kCGWindowMemoryUsage  ��  #<�^ ��_`�� 0 kCGWindowBounds  _ ��ab�� 0 X  a @      b ��cd�� 
0 Height  c @�P     d ��ef�� 	0 Width  e @��     f ��g���� 0 Y  g @6      ��  ` ��hi�� 0 kCGWindowOwnerName  h �jj 
 X c o d ei �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  f ����k�� 0 kCGWindowNumber  ��! k ��lm�� 0 kCGWindowAlpha  l ?�      m ����n�� 0 kCGWindowStoreType  �� n ����o�� 0 kCGWindowSharingState  �� o ����p�� 0 kCGWindowLayer  ��  p ����q�� 0 kCGWindowMemoryUsage  ��  �`q ��rs�� 0 kCGWindowBounds  r ��tu�� 0 X  t         u ��vw�� 
0 Height  v @�      w ��xy�� 	0 Width  x @D�     y ��z���� 0 Y  z @r@     ��  s ��{|�� 0 kCGWindowOwnerName  { �}} 
 X c o d e| ������� 0 kCGWindowOwnerPID  ����  g �~�}~�~ 0 kCGWindowNumber  �}!~ �|�{�| 0 kCGWindowOwnerPID  �{� �z���z 0 kCGWindowAlpha  � ?�      � �y���y 0 kCGWindowName  � ���  M o i r a e� �x�w��x 0 kCGWindowStoreType  �w � �v�u��v 0 kCGWindowWorkspace  �u � �t�s��t 0 kCGWindowSharingState  �s � �r�q��r 0 kCGWindowLayer  �q  � �p�o��p 0 kCGWindowMemoryUsage  �o  
��� �n���n 0 kCGWindowBounds  � �m���m 0 X  � @�$     � �l���l 
0 Height  � @}�     � �k���k 	0 Width  � @u�     � �j��i�j 0 Y  � @>      �i  � �h���h 0 kCGWindowOwnerName  � ��� 
 X c o d e� �g�f�e�g 0 kCGWindowIsOnscreen  
�f boovtrue�e  h �d�c��d 0 kCGWindowNumber  �c�� �b�a��b 0 kCGWindowOwnerPID  �a�� �`���` 0 kCGWindowAlpha  � ?�      � �_���_ 0 kCGWindowName  � ��� D a p p l e s c r i p t   b u t t o n   -   G o o g l e   S e a r c h� �^�]��^ 0 kCGWindowStoreType  �] � �\�[��\ 0 kCGWindowWorkspace  �[ � �Z�Y��Z 0 kCGWindowSharingState  �Y � �X�W��X 0 kCGWindowLayer  �W  � �V�U��V 0 kCGWindowMemoryUsage  �U  Q��� �T���T 0 kCGWindowBounds  � �S���S 0 X  � @��     � �R���R 
0 Height  � @�      � �Q���Q 	0 Width  � @�      � �P��O�P 0 Y  � ��8     �O  � �N���N 0 kCGWindowOwnerName  � ���  S a f a r i� �M�L�K�M 0 kCGWindowIsOnscreen  
�L boovtrue�K  i �J�I��J 0 kCGWindowNumber  �IA� �H���H 0 kCGWindowAlpha  � ?�      � �G���G 0 kCGWindowName  � ���  F i n d� �F�E��F 0 kCGWindowStoreType  �E � �D�C��D 0 kCGWindowSharingState  �C � �B�A��B 0 kCGWindowLayer  �A  � �@�?��@ 0 kCGWindowMemoryUsage  �?   �`� �>���> 0 kCGWindowBounds  � �=���= 0 X  � @u�     � �<���< 
0 Height  � @j      � �;���; 	0 Width  � @��     � �:��9�: 0 Y  � @b`     �9  � �8���8 0 kCGWindowOwnerName  � ���  S c r i p t   E d i t o r� �7�6�5�7 0 kCGWindowOwnerPID  �6 ��5  j �4�3��4 0 kCGWindowNumber  �3}� �2�1��2 0 kCGWindowOwnerPID  �1�� �0���0 0 kCGWindowAlpha  � ?�      � �/���/ 0 kCGWindowName  � ��� ` A p p l e S c r i p t   L a n g u a g e   G u i d e . p d f   ( p a g e   1 0 7   o f   4 1 5 )� �.�-��. 0 kCGWindowStoreType  �- � �,�+��, 0 kCGWindowWorkspace  �+ � �*�)��* 0 kCGWindowSharingState  �) � �(�'��( 0 kCGWindowLayer  �'  � �&�%��& 0 kCGWindowMemoryUsage  �%  O=�� �$���$ 0 kCGWindowBounds  � �#���# 0 X  �         � �"���" 
0 Height  � @�P     � �!���! 	0 Width  � @��     � � ���  0 Y  � @6      �  � ���� 0 kCGWindowOwnerName  � ���  S k i m� ���� 0 kCGWindowIsOnscreen  
� boovtrue�  k ���� 0 kCGWindowNumber  �|� ���� 0 kCGWindowAlpha  � ?�      � ���� 0 kCGWindowStoreType  � � ���� 0 kCGWindowSharingState  � � ���� 0 kCGWindowLayer  �  � ���� 0 kCGWindowMemoryUsage  �  S`� ���� 0 kCGWindowBounds  � ���� 0 X  �         � ���� 
0 Height  � @p      � ���� 	0 Width  � @j@     � ���
� 0 Y  � @�      �
  � �	���	 0 kCGWindowOwnerName  � ���  S k i m� ���� 0 kCGWindowOwnerPID  ���  l ���� 0 kCGWindowNumber  �{� ���� 0 kCGWindowAlpha  � ?�ff`   � ���� 0 kCGWindowName  � ���  � �� �� 0 kCGWindowStoreType  �  � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  �� � ������� 0 kCGWindowMemoryUsage  ��   �`� ������ 0 kCGWindowBounds  � ������ 0 X  � @`�     � ������ 
0 Height  � @^      � ��� �� 	0 Width  � @y        ������ 0 Y   @}      ��  � ���� 0 kCGWindowOwnerName   �  S k i m �������� 0 kCGWindowOwnerPID  �����  m ������ 0 kCGWindowNumber  ��x ���� 0 kCGWindowAlpha   ?�       ������ 0 kCGWindowStoreType  ��  ����	�� 0 kCGWindowSharingState  �� 	 ����
�� 0 kCGWindowLayer  ��  
 ������ 0 kCGWindowMemoryUsage  ��#` ���� 0 kCGWindowBounds   ���� 0 X            ���� 
0 Height   @X       ���� 	0 Width   @0       ������ 0 Y   @�      ��   ���� 0 kCGWindowOwnerName   �  S k i m �������� 0 kCGWindowOwnerPID  �����  n ������ 0 kCGWindowNumber  ��w ���� 0 kCGWindowAlpha   ?�       ������ 0 kCGWindowStoreType  ��  ������ 0 kCGWindowSharingState  ��  ������ 0 kCGWindowLayer  ��   ������ 0 kCGWindowMemoryUsage  ��C` �� �� 0 kCGWindowBounds   ��!"�� 0 X  !         " ��#$�� 
0 Height  # @k      $ ��%&�� 	0 Width  % @@      & ��'���� 0 Y  ' @�`     ��    ��()�� 0 kCGWindowOwnerName  ( �**  S k i m) �������� 0 kCGWindowOwnerPID  �����  o ����+�� 0 kCGWindowNumber  ��v+ ��,-�� 0 kCGWindowAlpha  , ?�      - ����.�� 0 kCGWindowStoreType  �� . ����/�� 0 kCGWindowSharingState  �� / ����0�� 0 kCGWindowLayer  ��  0 ����1�� 0 kCGWindowMemoryUsage  ��  #`1 ��23�� 0 kCGWindowBounds  2 ��45�� 0 X  4         5 ��67�� 
0 Height  6 @�0     7 ��89�� 	0 Width  8 @@      9 ��:���� 0 Y  : �X�     ��  3 ��;<�� 0 kCGWindowOwnerName  ; �==  S k i m< �������� 0 kCGWindowOwnerPID  �����  p ����>�� 0 kCGWindowNumber  ��u> ��?@�� 0 kCGWindowAlpha  ? ?�      @ ����A�� 0 kCGWindowStoreType  �� A ����B�� 0 kCGWindowSharingState  �� B ����C�� 0 kCGWindowLayer  ��  C ����D�� 0 kCGWindowMemoryUsage  ��  �`D ��EF�� 0 kCGWindowBounds  E ��GH�� 0 X  G         H ��IJ�� 
0 Height  I @t�     J ��KL�� 	0 Width  K @d�     L ��M���� 0 Y  M @��     ��  F ��NO�� 0 kCGWindowOwnerName  N �PP  S k i mO �������� 0 kCGWindowOwnerPID  �����  q ����Q�� 0 kCGWindowNumber  ���Q ��RS�� 0 kCGWindowAlpha  R ?�      S ��TU�� 0 kCGWindowName  T �VV  U ����W�� 0 kCGWindowStoreType  �� W ����X�� 0 kCGWindowSharingState  �� X ����Y�� 0 kCGWindowLayer  �� gY ����Z�� 0 kCGWindowMemoryUsage  ��`Z ��[\�� 0 kCGWindowBounds  [ ��]^�� 0 X  ] @��     ^ ��_`�� 
0 Height  _ @2      ` ��ab�� 	0 Width  a @S�     b ��c���� 0 Y  c �rp     ��  \ ��de�� 0 kCGWindowOwnerName  d �ff  S a f a r ie �������� 0 kCGWindowOwnerPID  �����  r ����g�� 0 kCGWindowNumber  ��Eg ��hi�� 0 kCGWindowAlpha  h ?�      i ����j�� 0 kCGWindowStoreType  �� j ���k�� 0 kCGWindowSharingState  � k �~�}l�~ 0 kCGWindowLayer  �}  l �|�{m�| 0 kCGWindowMemoryUsage  �{`m �zno�z 0 kCGWindowBounds  n �ypq�y 0 X  p         q �xrs�x 
0 Height  r @L      s �wtu�w 	0 Width  t @4      u �vv�u�v 0 Y  v @�`     �u  o �twx�t 0 kCGWindowOwnerName  w �yy  S a f a r ix �s�r�q�s 0 kCGWindowOwnerPID  �r��q  s �p�oz�p 0 kCGWindowNumber  �o�z �n{|�n 0 kCGWindowAlpha  { ?�      | �m�l}�m 0 kCGWindowStoreType  �l } �k�j~�k 0 kCGWindowSharingState  �j ~ �i�h�i 0 kCGWindowLayer  �h   �g�f��g 0 kCGWindowMemoryUsage  �f`� �e���e 0 kCGWindowBounds  � �d���d 0 X  �         � �c���c 
0 Height  � @0      � �b���b 	0 Width  � @=      � �a��`�a 0 Y  � @��     �`  � �_���_ 0 kCGWindowOwnerName  � ���  S a f a r i� �^�]�\�^ 0 kCGWindowOwnerPID  �]��\  t �[�Z��[ 0 kCGWindowNumber  �Z�� �Y���Y 0 kCGWindowAlpha  � ?�      � �X�W��X 0 kCGWindowStoreType  �W � �V�U��V 0 kCGWindowSharingState  �U � �T�S��T 0 kCGWindowLayer  �S  � �R�Q��R 0 kCGWindowMemoryUsage  �Q   �`� �P���P 0 kCGWindowBounds  � �O���O 0 X  �         � �N���N 
0 Height  � @��     � �M���M 	0 Width  � @0      � �L��K�L 0 Y  � @q@     �K  � �J���J 0 kCGWindowOwnerName  � ���  S a f a r i� �I�H�G�I 0 kCGWindowOwnerPID  �H��G  u �F�E��F 0 kCGWindowNumber  �E�� �D���D 0 kCGWindowAlpha  � ?�      � �C���C 0 kCGWindowName  � ���  � �B�A��B 0 kCGWindowStoreType  �A � �@�?��@ 0 kCGWindowSharingState  �? � �>�=��> 0 kCGWindowLayer  �=  � �<�;��< 0 kCGWindowMemoryUsage  �;  3`� �:���: 0 kCGWindowBounds  � �9���9 0 X  � @�     � �8���8 
0 Height  � @p�     � �7���7 	0 Width  � @w0     � �6��5�6 0 Y  � @R�     �5  � �4���4 0 kCGWindowOwnerName  � ���  S a f a r i� �3�2�1�3 0 kCGWindowOwnerPID  �2��1  v �0�/��0 0 kCGWindowNumber  �/	� �.���. 0 kCGWindowAlpha  � ?�      � �-�,��- 0 kCGWindowStoreType  �, � �+�*��+ 0 kCGWindowSharingState  �* � �)�(��) 0 kCGWindowLayer  �(  � �'�&��' 0 kCGWindowMemoryUsage  �&#`� �%���% 0 kCGWindowBounds  � �$���$ 0 X  �         � �#���# 
0 Height  � @a      � �"���" 	0 Width  � @0      � �!�� �! 0 Y  � @��     �   � ���� 0 kCGWindowOwnerName  � ���  M a i l� ���� 0 kCGWindowOwnerPID  ���  w ���� 0 kCGWindowNumber  ��� ���� 0 kCGWindowOwnerPID  ��� ���� 0 kCGWindowAlpha  � ?�      � ���� 0 kCGWindowName  � ��� * I n b o x   ( 5 7 7 8   m e s s a g e s )� ���� 0 kCGWindowStoreType  � � ���� 0 kCGWindowWorkspace  � � ���� 0 kCGWindowSharingState  � � ���� 0 kCGWindowLayer  �  � ���� 0 kCGWindowMemoryUsage  �  A?�� ���� 0 kCGWindowBounds  � �
���
 0 X  � @��     � �	���	 
0 Height  � @�      � ���� 	0 Width  � @��     � ���� 0 Y  � ��8     �  � ���� 0 kCGWindowOwnerName  � ���  M a i l� ���� 0 kCGWindowIsOnscreen  
� boovtrue�  x �� �� 0 kCGWindowNumber  � �� ������ 0 kCGWindowAlpha  � ?�      � ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  �`� ������ 0 kCGWindowBounds  � ������ 0 X  � @y      � ������ 
0 Height  � @``     � ������ 	0 Width  � @z@     � ������� 0 Y  � @Y      ��  � ������ 0 kCGWindowOwnerName  � ���  S c r i p t   E d i t o r� �������� 0 kCGWindowOwnerPID  �� ���  y ������� 0 kCGWindowNumber  ���� ������� 0 kCGWindowOwnerPID  �� �� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ���  p L i s t   5 0 0 0� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowWorkspace  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  \� �� �� 0 kCGWindowBounds    ���� 0 X   @vP      ���� 
0 Height   @�8      ���� 	0 Width   @�      ������ 0 Y   @6      ��   ��	
�� 0 kCGWindowOwnerName  	 �  S c r i p t   E d i t o r
 �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  z ������ 0 kCGWindowNumber  ��� ���� 0 kCGWindowAlpha   ?�       ���� 0 kCGWindowName   �   ������ 0 kCGWindowStoreType  ��  ������ 0 kCGWindowSharingState  ��  ������ 0 kCGWindowLayer  �� e ������ 0 kCGWindowMemoryUsage  ��` ���� 0 kCGWindowBounds   ���� 0 X   @p�      ���� 
0 Height   @i       ���� 	0 Width   @k�      ������ 0 Y   @|P     ��   �� �� 0 kCGWindowOwnerName   �!!  S c r i p t   E d i t o r  �������� 0 kCGWindowOwnerPID  �� ���  { ����"�� 0 kCGWindowNumber  �� �" ����#�� 0 kCGWindowOwnerPID  �� �# ��$%�� 0 kCGWindowAlpha  $ ?�      % ��&'�� 0 kCGWindowName  & �((  ' ����)�� 0 kCGWindowStoreType  �� ) ����*�� 0 kCGWindowSharingState  �� * ����+�� 0 kCGWindowLayer  �� + ����,�� 0 kCGWindowMemoryUsage  ��`, ��-.�� 0 kCGWindowBounds  - ��/0�� 0 X  / @�8     0 ��12�� 
0 Height  1 @6      2 ��34�� 	0 Width  3 @8      4 ��5���� 0 Y  5         ��  . ��67�� 0 kCGWindowOwnerName  6 �88  D r o p b o x7 �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  | ����9�� 0 kCGWindowNumber  �� ~9 ��:;�� 0 kCGWindowAlpha  : ?�      ; ��<=�� 0 kCGWindowName  < �>> & D r o p b o x   P r e f e r e n c e s= ����?�� 0 kCGWindowStoreType  �� ? ����@�� 0 kCGWindowSharingState  �� @ ����A�� 0 kCGWindowLayer  ��  A ����B�� 0 kCGWindowMemoryUsage  ��`B ��CD�� 0 kCGWindowBounds  C ��EF�� 0 X  E         F ��GH�� 
0 Height  G @o@     H ��IJ�� 	0 Width  I @y      J ��K���� 0 Y  K @6      ��  D ��LM�� 0 kCGWindowOwnerName  L �NN  D r o p b o xM �������� 0 kCGWindowOwnerPID  �� ���  } ����O�� 0 kCGWindowNumber  �� !O ����P�� 0 kCGWindowOwnerPID  �� �P ��QR�� 0 kCGWindowAlpha  Q ?�      R ��ST�� 0 kCGWindowName  S �UU  T ����V�� 0 kCGWindowStoreType  �� V ����W�� 0 kCGWindowSharingState  �� W ����X�� 0 kCGWindowLayer  �� X ����Y�� 0 kCGWindowMemoryUsage  ��#`Y ��Z[�� 0 kCGWindowBounds  Z �\]� 0 X  \ @��     ] �~^_�~ 
0 Height  ^ @6      _ �}`a�} 	0 Width  ` @A      a �|b�{�| 0 Y  b         �{  [ �zcd�z 0 kCGWindowOwnerName  c �ee  C a f f e i n ed �y�x�w�y 0 kCGWindowIsOnscreen  
�x boovtrue�w  � �vf�v 	f 	 ghijklmnog �u�tp�u 0 kCGWindowNumber  �t !p �s�rq�s 0 kCGWindowOwnerPID  �r �q �qrs�q 0 kCGWindowAlpha  r ?�      s �ptu�p 0 kCGWindowName  t �vv  u �o�nw�o 0 kCGWindowStoreType  �n w �m�lx�m 0 kCGWindowSharingState  �l x �k�jy�k 0 kCGWindowLayer  �j y �i�hz�i 0 kCGWindowMemoryUsage  �h#`z �g{|�g 0 kCGWindowBounds  { �f}~�f 0 X  } @��     ~ �e��e 
0 Height   @6      � �d���d 	0 Width  � @A      � �c��b�c 0 Y  �         �b  | �a���a 0 kCGWindowOwnerName  � ���  C a f f e i n e� �`�_�^�` 0 kCGWindowIsOnscreen  
�_ boovtrue�^  h �]�\��] 0 kCGWindowNumber  �\ �� �[�Z��[ 0 kCGWindowOwnerPID  �Z �� �Y���Y 0 kCGWindowAlpha  � ?�      � �X���X 0 kCGWindowName  � ���  � �W�V��W 0 kCGWindowStoreType  �V � �U�T��U 0 kCGWindowSharingState  �T � �S�R��S 0 kCGWindowLayer  �R � �Q�P��Q 0 kCGWindowMemoryUsage  �P`� �O���O 0 kCGWindowBounds  � �N���N 0 X  � @�8     � �M���M 
0 Height  � @6      � �L���L 	0 Width  � @8      � �K��J�K 0 Y  �         �J  � �I���I 0 kCGWindowOwnerName  � ���  D r o p b o x� �H�G�F�H 0 kCGWindowIsOnscreen  
�G boovtrue�F  i �E�D��E 0 kCGWindowNumber  �D!'� �C�B��C 0 kCGWindowOwnerPID  �B�� �A���A 0 kCGWindowAlpha  � ?�      � �@���@ 0 kCGWindowName  � ��� * C l o t h o S c r e e n W a t c h e r . m� �?�>��? 0 kCGWindowStoreType  �> � �=�<��= 0 kCGWindowWorkspace  �< � �;�:��; 0 kCGWindowSharingState  �: � �9�8��9 0 kCGWindowLayer  �8  � �7�6��7 0 kCGWindowMemoryUsage  �6  )t\� �5���5 0 kCGWindowBounds  � �4���4 0 X  � @�      � �3���3 
0 Height  � @�P     � �2���2 	0 Width  � @�x     � �1��0�1 0 Y  � @6      �0  � �/���/ 0 kCGWindowOwnerName  � ��� 
 X c o d e� �.�-�,�. 0 kCGWindowIsOnscreen  
�- boovtrue�,  j �+�*��+ 0 kCGWindowNumber  �*!#� �)�(��) 0 kCGWindowOwnerPID  �(�� �'���' 0 kCGWindowAlpha  � ?�      � �&���& 0 kCGWindowName  � ���  C l o t h o L o g g e r . m� �%�$��% 0 kCGWindowStoreType  �$ � �#�"��# 0 kCGWindowWorkspace  �" � �!� ��! 0 kCGWindowSharingState  �  � ���� 0 kCGWindowLayer  �  � ���� 0 kCGWindowMemoryUsage  �  #<�� ���� 0 kCGWindowBounds  � ���� 0 X  � @      � ���� 
0 Height  � @�P     � ���� 	0 Width  � @��     � ���� 0 Y  � @6      �  � ���� 0 kCGWindowOwnerName  � ��� 
 X c o d e� ���� 0 kCGWindowIsOnscreen  
� boovtrue�  k ���� 0 kCGWindowNumber  �!� ���� 0 kCGWindowOwnerPID  ��� ���� 0 kCGWindowAlpha  � ?�      � ���� 0 kCGWindowName  � ���  M o i r a e� ��
�� 0 kCGWindowStoreType  �
 � �	���	 0 kCGWindowWorkspace  � � ���� 0 kCGWindowSharingState  � � ���� 0 kCGWindowLayer  �  � ���� 0 kCGWindowMemoryUsage  �  
��� ���� 0 kCGWindowBounds  � � ���  0 X  � @�$     � ������ 
0 Height  � @}�     � ������ 	0 Width  � @u�     � ������� 0 Y  � @>      ��  � ������ 0 kCGWindowOwnerName  � ��� 
 X c o d e� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  l ������� 0 kCGWindowNumber  ���� ������� 0 kCGWindowOwnerPID  �� �� ������ 0 kCGWindowAlpha  � ?�      � ������ 0 kCGWindowName  � ���  p L i s t   5 0 0 0� ������� 0 kCGWindowStoreType  �� � ������� 0 kCGWindowWorkspace  �� � ������� 0 kCGWindowSharingState  �� � ������� 0 kCGWindowLayer  ��  � ������� 0 kCGWindowMemoryUsage  ��  \� ������ 0 kCGWindowBounds  � ������ 0 X  � @vP     � ������ 
0 Height  � @�8     � ������ 	0 Width  � @�     � ������� 0 Y  � @6      ��  � ������ 0 kCGWindowOwnerName  � ���  S c r i p t   E d i t o r� �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  m ������� 0 kCGWindowNumber  ��}� ������� 0 kCGWindowOwnerPID  ���� ��	 	�� 0 kCGWindowAlpha  	  ?�      	 ��		�� 0 kCGWindowName  	 �		 ` A p p l e S c r i p t   L a n g u a g e   G u i d e . p d f   ( p a g e   1 0 7   o f   4 1 5 )	 ����	�� 0 kCGWindowStoreType  �� 	 ����	�� 0 kCGWindowWorkspace  �� 	 ����	�� 0 kCGWindowSharingState  �� 	 ����	�� 0 kCGWindowLayer  ��  	 ����		�� 0 kCGWindowMemoryUsage  ��  O=�		 ��	
	�� 0 kCGWindowBounds  	
 ��		�� 0 X  	         	 ��		�� 
0 Height  	 @�P     	 ��		�� 	0 Width  	 @��     	 ��	���� 0 Y  	 @6      ��  	 ��		�� 0 kCGWindowOwnerName  	 �		  S k i m	 �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  n ����	�� 0 kCGWindowNumber  ���	 ����	�� 0 kCGWindowOwnerPID  ���	 ��		�� 0 kCGWindowAlpha  	 ?�      	 ��		�� 0 kCGWindowName  	 �		 D a p p l e s c r i p t   b u t t o n   -   G o o g l e   S e a r c h	 ����	�� 0 kCGWindowStoreType  �� 	 ����	�� 0 kCGWindowWorkspace  �� 	 ����	�� 0 kCGWindowSharingState  �� 	 ����	 �� 0 kCGWindowLayer  ��  	  ����	!�� 0 kCGWindowMemoryUsage  ��  Q��	! ��	"	#�� 0 kCGWindowBounds  	" ��	$	%�� 0 X  	$ @��     	% ��	&	'�� 
0 Height  	& @�      	' ��	(	)�� 	0 Width  	( @�      	) ��	*���� 0 Y  	* ��8     ��  	# ��	+	,�� 0 kCGWindowOwnerName  	+ �	-	-  S a f a r i	, �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  o ����	.�� 0 kCGWindowNumber  ���	. ����	/�� 0 kCGWindowOwnerPID  ���	/ ��	0	1�� 0 kCGWindowAlpha  	0 ?�      	1 ��	2	3�� 0 kCGWindowName  	2 �	4	4 * I n b o x   ( 5 7 7 8   m e s s a g e s )	3 ����	5�� 0 kCGWindowStoreType  �� 	5 ����	6�� 0 kCGWindowWorkspace  �� 	6 ����	7�� 0 kCGWindowSharingState  �� 	7 ����	8�� 0 kCGWindowLayer  ��  	8 ����	9�� 0 kCGWindowMemoryUsage  ��  A?�	9 ��	:	;�� 0 kCGWindowBounds  	: ��	<	=�� 0 X  	< @��     	= ��	>	?�� 
0 Height  	> @�      	? ��	@	A�� 	0 Width  	@ @��     	A ��	B���� 0 Y  	B ��8     ��  	; ��	C	D�� 0 kCGWindowOwnerName  	C �	E	E  M a i l	D �������� 0 kCGWindowIsOnscreen  
�� boovtrue��  ����� ��	F�� #	F # ��������������������������������~�}�|�{�z�y�x�w�v�u�t�s�r�q�p�o�n�m�l��!R��!D��!4��!3��!.��!-��!*��!)��!'��!$��!#��! ��!�����A�}�~|�}{�|x�{w�zv�yu�x��wE�v��u��t��s	�r��q��p��o��n ��m ~�l !� �k	G�k 		G 	 �j�i�h�g�f�e�d�c�b�j !�i ��h!'�g!#�f!�e��d}�c��b�� �  � �a	H�a #	H # ������������������
"%(+.1� �`	I�` #	I # �_�^�]�\�[�Z�Y�X�W�V�U�T�S�R�Q�P�O�N�M�L�K�J�I�H�G�F�E�D�C�B�A�@�?�>�=�_��^��]��\��[��Z��Y��X��W��V��U��T��S��R��Q ��P��O��N��M��L��K��J��I��H��G��F��E��D��C��B ��A ��@ ��? ��> ��= �� �<	J�< 	J  �;�;�� �:	K�: 	K  ��  ���  �  �  �   ascr  ��ޭ