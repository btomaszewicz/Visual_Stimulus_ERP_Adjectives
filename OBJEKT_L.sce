##############################################################################
##                                                                          ##
##     Template : Visual ERP Study with Pictures, Text and '???' Questions  ##
##             Experiment Script for use with Presentation                  ##
##                 Adapted from Sylvia, Markus & Torsten                    ##
##                       Author: R. Muralikrishnan                          ##
##                           Modification: BT                               ##
##                         OBJEKTBESCHREIBUNGEN                             ##
##############################################################################

##############################################################################
# Scenario Description Language (SDL) Header Part
##############################################################################

# These button codes have to correspond to those set in 'Settings -> Response'
active_buttons = 3;      # There are 3 active buttons defined in 'Settings -> Response'
button_codes = 1,2,3;    # These are the codes of those buttons

response_matching = simple_matching;  # Enables features not in legacy_matching

# Only those button presses that one expects are logged; not all
response_logging = log_active;

# Needed for EEG Trigger files
write_codes = true;
pulse_width = 5;
default_output_port = 1;  # This is most probably going to be the same for everyone.
# This is the LPT Parallel port that you will define in the Port settings tab of
# Presentation.  This will be used as the output port for sending codes to EEG.
# Defining this here saves getting a port number in the PCL part from the output_manager
# and calling send_code etc.  Stimulus events themselves will send these for us, provided we
# define the correct port_codes in each Stimulus event.


# Default Settings for Font, FG and BG Colours etc.
default_background_color = "255, 255, 255"; # RGB codes in decimal; WHITE
default_font = "Verdana";
default_font_size = 32;
default_text_color = "47, 79, 79"; # DIMGREY, 47, 79, 79 DARKSLATEGREY, "105, 105, 105"; # DIMGREY
default_text_align = align_center;
#default_background_color = "51, 51, 255";  # RGB codes in decimal; INDYGO
#default_text_color = "255,255, 255";#"black"; #  # An off-bluish foreground


default_deltat = 0;
default_picture_duration = next_picture; /* This implies that all pictures ...
/...are shown until the next picture is shown, unless otherwise specified */

#default_all_responses = false;


##############################################################################
# Scenario Description Language (SDL) Part
##############################################################################

begin;

# ============================
# SDL Variable Declarations: -
# ============================

#
# We don't use any variables.  All the timer parameters appear as numbers.


# ==============================
# Picture Stimuli Definitions: - Everything that is shown, including text!
# ==============================

# Screen definition for the trial that starts an Experimental Session.
# Used as the first screen that the participant sees.  Operator Controlled.
picture
{
   text { caption = "Das Experiment beginnt gleich..."; };
    x = 0;
    y = 0;
} P_Start_Exp;

# Screen definition for the Pause trial
# Operator Controlled!
picture
{
   text { caption = "Kurze Pause."; };
    x = 0;
    y = 0;
} P_Pause;

# Screen definition for the Continue trial
# Participant Controlled!
picture
{
    text { caption = "Drücke eine Taste um fortzufahren."; };
    x = 0;
    y = 0;
} P_Continue;

# Screen definition for the Interruption trial
# Operator Controlled!
picture
{
   text { caption = "Gleich geht's weiter..."; };
    x = 0;
    y = 0;
} P_Interruption;

#Markus sein Trick ##WHY NOT THE ORIGINAL P_Interruption ?
picture {
	text {
		caption = "Bitte warten...";
	};
	x = 0;
	y = 0;
} pic_before;


# Screen definition for showing the focus star
picture  {
	text {
		caption = "*";
		font_size = 50;
	};
	x = 0;
	y = 0;
} P_Focus_Star;


#A bitmap picture part is one of the elements that picture stimuli can contain.
#Bitmap picture parts contain graphic images that are loaded from files on your computer. Although they are displayed using "bitmap" picture parts, these graphics files may be stored in any of the following formats:
#BMP, JPEG, PCX, GIF (not animated), ICO, JPC, PNG, RAS, TGA, WBMP, TIF

# Screen definition for showing the Picture Card

picture
{
   #box { width = 900; height = 360; color = "255, 255, 255"; };  # Draw a white box of the specified width and height.
   #x = 0;
   #y = 0;

   bitmap { filename = ""; preload = false;} Png_Picture_Context1;     # PCL Program below fills the file name
   x = 0;
   y = 0;

} P_Picture_Context1;

picture
{

   bitmap { filename = ""; preload = false;} Png_Picture_Context2;     # PCL Program below fills the file name
   x = 0;
   y = 0;

} P_Picture_Context2;




# Screen definition for showing the question mark
picture
{
   text { caption = "Stimmt das?";
   font_size = 32;
};
    x = 0;
    y = 0;
} P_Show_Question_Mark;

# Screen definition for the End_Thanks trial
picture
{
    text {caption = "Geschafft!\nVielen Dank.";};
    x = 0;
    y = 0;
} P_End_Thanks;



####  Specific for presenting Visual Stimuli   --------------------------------
# Screen definition for the trial that presents Visual Stimuli word-by-word.
picture
{
   text { caption = " "; } Txt_Visual_Stimulus;
    x = 0;
    y = 0;
} P_Visual_Stimulus;

####

#####


#=====================
# Trial Definitions: -
#=====================

/****
/  Note that the name 'Trial' could be misleading.  Unless otherwise specified,
/  what we mean by a 'Trial' here is actually a sub-trial or sub-task that is
/  part - and thereby defines the structure - of an actual experimental trial.
****/

/****
/ Template for defining an SDL Trial.
/ trial
/ {
/      Trial-related parameters such as trial_duration, trial_type etc.
/     Trial-related parameters
/
/     Stimulus event 1 such as picture, sound, video, nothing or force-FB;
/     Stimulus event parameters such as time, event code etc.
/     If the parameters aren't specified, the default values are used!!!
/
/     Stimulus event 2;
/     its parameters...and so on
/ }
****/

# Screen definition of the Trial to show a Blank Screen between Experimental Trials
trial
{
    trial_duration = 1000;
    all_responses = false;

    stimulus_event
    {
        picture {};     # This is the default picture, which is nothing!
 #       code = "CLS";   # Comment this out to avoid seeing this in the logfile.
    } E_Blank_Screen;
} T_Blank_Screen;


# Definition of the Trial to start an Experimental Session.
# Operator Controlled!
trial
{
    trial_duration = forever;       # Keep running the trial...
    trial_type = specific_response; # ...until the following specific response.
    terminator_button = 3;          # Operator PC - ENTER key.

    stimulus_event
    {
        picture P_Start_Exp;        # Show P_Start_Exp.
  #      code = "The Experiment starts now!";
    };
} T_Start_Exp;


# Definition of the Trial to continue further.
# Participant Controlled!
trial
{
    trial_duration = forever;        # Keep running the trial...
    trial_type = specific_response;  # ...until the following specific response.
    terminator_button = 1,2,3;         # Participant Joystick - L or R button.

    stimulus_event
    {
        picture P_Continue;          # Show P_Continue.
 #       code = "Trials follow!";
    };
} T_Continue;


# Definition of the Trial to Launch an Experimental Trial
trial
{
    trial_duration = 400;       # Run the trial for 400 ms...
    all_responses = false;      # ..without recognising any key presses.

    stimulus_event
    {
        picture P_Focus_Star;   # Show the focus star for fixation.
        code = "";              # Code set below in the PCL program.
        # port_code = ;         # Port code set by the PCL program.
    } E_Launch_New_Trial;
} T_Launch_New_Trial;


# Definition of the Trial to keep showing the Focus Star for fixation.
trial
{
    trial_duration = 500;      # Show star until the next clear-screen...
    all_responses = false;      # ..without recognising any key presses.
    stimulus_event
    {
        picture P_Focus_Star;   # Show the focus star for fixation.
        code = "*";             # Comment this out later to avoid seeing this in the log file.
    };
} T_Keep_Showing_Star;

# Definition of the Trial to keep showing the Question Mark for fixation.

trial
{
    trial_duration = 5000;      # Show ??? until the next clear-screen...
	 trial_type = specific_response;
    terminator_button = 1,2,3;      # ..without recognising any key presses.

    stimulus_event
    {
        picture P_Show_Question_Mark;
			code = "195";             # Send '195' to EEG
			port_code = 195;
			#target_button = 2,1;        # PCL sets this
    }E_Show_Question_Mark;
} T_Show_Question_Mark;


####  Specific for presenting Visual Stimuli   --------------------------------
# Definition of the Trial to present Visual Stimuli word-by-word
trial
{
   trial_duration = 450;  # PCL Program changes this!!!  TEST - Eventuell auf 450 hochgehen?
    all_responses = false;

    stimulus_event
    {
        picture P_Visual_Stimulus;
        code = "";  # PCL Program fills this!!!
        # port_code = ; # PCL Program fills this!!!
    } E_Visual_Stimulus;
} T_Visual_Stimulus;

####


# Definition of the Trial to show the Picture Card CONTEXTS

trial
{
   trial_duration = 3000;  # Show pic with no frame for a maximum of 3 seconds.
   all_responses = false;

    stimulus_event
    {
        picture P_Picture_Context1;
        code = "";                    # PCL Program sets this.
        #port_code = 195;              # Send '195' to EEG ------------------- SET IN PCL?
        # target_button = 1,2;        # PCL Program sets this.
    } E_Picture_Context1;
} T_Picture_Context1;

trial
{
   trial_duration = 6000;  # Show the pic with a frame for a maximum of 6 seconds. ------- CHECK!!!!
#   trial_type = specific_response;
#   terminator_button = 1,2;  # The exact response can be either of these;

    stimulus_event
    {
        picture P_Picture_Context2;
        code = "";                    # PCL Program sets this.
        #port_code = 195;              # Send '195' to EEG ------------------- SET IN PCL?
        # target_button = 1,2;        # PCL Program sets this.
    } E_Picture_Context2;
} T_Picture_Context2;





# Definition of the Trial to send a code indicating that a Timeout has occurred.
/* When a button-pressed response occurs, 1 or 2 is sent to EEG depending upon the button pressed.
   When a timeout occurs, nothing gets sent.  Just in order to have equal number of lines in the
   trigger files later, it's better to send a code indicating timeout.
   (Yes, IN ADDITION to the usual code 199 that will follow.)
*/
trial
{
    trial_duration = 10;
    all_responses = false;

    stimulus_event
    {
        nothing {};                  # This is the default picture, which is nothing!
        code = "Timeout";
        port_code = 3;
    } E_Report_Timeout_to_EEG;
} T_Report_Timeout_to_EEG;


# Definition of the Trial to send the response code to EEG
trial
{
    trial_duration = 20;
    all_responses = false;

    stimulus_event
    {
        nothing {};                 # Basically, nothing is done!
        time = 15;
        /* Start this event 15 seconds after the trial starts.  This is to provide a delay in
         sending the code to EEG to avoid trying to reach the port when it is still busy
           having just received the response 1 or 2 from the button box, or the timeout code.
        */
        # code = "Send Code";      # Comment this out to avoid seeing this in the logfile.
        # port_code = 196, 197 or 199, PCL Program fills this!!!
    } E_Response_Code_to_EEG;
} T_Response_Code_to_EEG;


# Definition of the Trial to show a Pause
# Operator Controlled
trial
{
    trial_duration = forever;
    trial_type = specific_response;
    terminator_button = 3;

    stimulus_event
    {
        picture P_Pause;
        code = "Pause";
    };
} T_Pause;


# Definition of the Trial to Interrupt in the middle of a session
# Operator Controlled
trial
{
    trial_duration = forever;
    trial_type = specific_response;
    terminator_button = 3;

    stimulus_event
    {
        picture P_Interruption;       #________________________BUT WE DIDN'T DEFINE THIS
        code = "Interrupted!!!";
    };
} T_Interruption;

# Definition of the Trial to end the session
# Operator Controlled
trial
{
    trial_duration = forever;
    all_responses = false;
    trial_type = first_response;

    stimulus_event
    {
        picture P_End_Thanks;
        code = "End of Session!";
    };
    picture P_End_Thanks;
} T_End_Thanks;

##############################################################################
# Presentation Control Language (PCL) Program Part
##############################################################################

begin_pcl;

int N_of_Trials = 280;                          # TEST Number of Experimental Trials per Session.
int N_of_Blocks = 7;                                # Number of Blocks per Session.
int N_of_Trials_per_Block = N_of_Trials/N_of_Blocks; # Number of Experimental Trials per Block.

preset string V_Version; # Prompt the version at the beginning!!!


input_file F_Session_List = new input_file;
F_Session_List.open("Session_List_" + V_Version + ".txt");
# This is the file containing the list of stimuli for one session.______________________Session_List_01.txt
# Each line in this file must correspond to one experimental trial.

####  Specific for presenting Visual Stimuli   --------------------------------

input_file F_Visual_Stimulus = new input_file;
F_Visual_Stimulus.open("Visual_Stimulus_List_" + V_Version + ".txt"); #________________Visual_Stimulus_List_01.txt
string V_Visual_Stimulus;
array<string> A_Stimulus_Words[0];

####  Specific for presenting Visual Stimuli + Text Comprehension Question  ---

int V_Current_Word;
int V_Underscore_Index;
int V_Star_Index;




####



# Columns of strings in the order found in the input Session List file.

string V_Picture_Context1;
string V_Picture_Context2;
string V_Item;
string V_Condition;
string V_Condition_Code;  #TRIGGERS!
####string V_Comp_Question;   #with ???, I only specify F or T in the Session List
string V_Expected_Response;




# output_port O_Port_to_EEG = output_port_manager.get_port(1);
stimulus_data D_Stimulus_Data = stimulus_manager.last_stimulus_data();

#========================
# Main Experiment Loop: -
#========================
loop     /*** Begin Main Loop 1 for Blocks ***/
    int V_Current_Block = 1

until
    V_Current_Block > N_of_Blocks

begin
    if V_Current_Block == 1 then
        T_Start_Exp.present();
    else
        T_Pause.present();
    end;

    T_Continue.present();
    T_Blank_Screen.present();


    #==========
    # Loop 2: -
    #==========
    loop    /*** Begin Loop 2 for Trials ***/
        int V_Current_Trial = 1

    until
        V_Current_Trial > N_of_Trials_per_Block

    begin
        V_Picture_Context1 = F_Session_List.get_string();   # Eg: famous-tower.png
        V_Picture_Context2 = F_Session_List.get_string();   # Eg: famous-tower-yes.png
        V_Item = F_Session_List.get_string();               # Eg: 1
        V_Condition = F_Session_List.get_string();          # Eg: world-yes
        V_Condition_Code = F_Session_List.get_string();     # Eg: 210
        #V_Comp_Question = F_Session_List.get_string();      # Eg: no quetions here!
        V_Expected_Response = F_Session_List.get_string(); # Eg: 2 (Left button => Correct)




        # Do filename and event-code assignments valid during this exp-trial;
        # Load wavefile and bitmap stimuli that are needed for this trial;
        /* We do this before launching the experimental trial so as to keep
           as minimal intereference as possible in trial timings.  You see,
           these things consume processor time, however small they are!
        */

        E_Launch_New_Trial.set_event_code((V_Item));
        #E_Cont_Sentence.set_target_button(int(V_Expected_Response));
		  E_Show_Question_Mark.set_target_button(int(V_Expected_Response)); #this codes hits and incorrects, without this everything is a hit b/c 1-2 are target buttons

        Png_Picture_Context1.set_filename(V_Picture_Context1);
        Png_Picture_Context1.load();
        #E_Picture_Context1.set_target_button(int(V_Expected_Response));
        #E_Picture_Context1.set_event_code(V_Picture_Context1);

        Png_Picture_Context2.set_filename(V_Picture_Context2);
        Png_Picture_Context2.load();
        #E_Picture_Context2.set_target_button(int(V_Expected_Response)); --- this expects a response at the picture and gives 'miss'
        E_Picture_Context2.set_event_code(V_Picture_Context2);


        # Execute the Experimental Trial!!!

        # O_Port_to_EEG.send_code(int(V_Item));               # Send Item number to EEG
        E_Launch_New_Trial.set_port_code(int(V_Item));
        T_Launch_New_Trial.present();                         # Show Star for 500 ms


 /*****************  Visual Stimulus Presentation Begins  ***********************/

        T_Blank_Screen.set_duration(150);
        E_Blank_Screen.set_port_code(180 + V_Current_Block); # Send Trigger with Block ID
        T_Blank_Screen.present();

		  E_Blank_Screen.set_port_code(port_code_none);        # Reset port code for all other blank screens!


/************ Picture CONTEXT 1 Begins *****************/
			 #E_Picture_Context1.set_port_code(int(V_Condition_Code));
          T_Picture_Context1.present();

/************ Picture CONTEXT 1 Ends *******************/

/************ Picture CONTEXT 2 Begins *****************/
			 E_Picture_Context2.set_port_code(int(V_Condition_Code));
         T_Picture_Context2.present();

/************ Picture CONTEXT 2 Ends *******************/



/*****************  Visual Stimulus Presentation Begins  ***********************/

        T_Blank_Screen.set_duration(150);
        T_Blank_Screen.present();

        T_Keep_Showing_Star.present();                        # Show Star for 500 ms

        T_Blank_Screen.set_duration(150);
        T_Blank_Screen.present();

        A_Stimulus_Words.resize(0);                       # Empty the array of words.
        V_Visual_Stimulus = F_Visual_Stimulus.get_line(); # Read one line at a time from the file.

        # Split it word by word.  If two words need to be together, there must be an _ in the input!
        V_Visual_Stimulus.split(" ",A_Stimulus_Words);

        # Present the words (or word pairs or word triplets) one by one.
        #============
        # Loop 2.1: -
        #============
        loop    /*** Begin Loop 2.1 for Stimulus Words ***/
            V_Current_Word = 2 # Leave the first one out, because that's the Stimulus Number or Index or so.
        until
            V_Current_Word > A_Stimulus_Words.count()
        begin
				# IN OBJEKT THERE ARE NO DOUBLE WORDS OR TRIPLETS
            /* Find if there's an underscore in the current array element somewhere.
               If there's one, replace it with a space (ASCII Char 32) before presenting the words.
               An underscore means that the words need to be presented together, as in 'Of course'!
            */
           # V_Underscore_Index = A_Stimulus_Words[V_Current_Word].find("_");
           # if V_Underscore_Index != 0 then
           #     A_Stimulus_Words[V_Current_Word].set_char(V_Underscore_Index, 32); # 32 -> Space
           #     T_Visual_Stimulus.set_duration(450);              # Show double words for 400 ms
           # end;

            /* Do the same thing again, if you thing you'll have to present 3 words at a time.
               But comment this out if you don't have triplets.  Saves time!!!
            */
          #  V_Underscore_Index = A_Stimulus_Words[V_Current_Word].find("_");
          #  if V_Underscore_Index != 0 then
          #      A_Stimulus_Words[V_Current_Word].set_char(V_Underscore_Index, 32);
          #      T_Visual_Stimulus.set_duration(500);  # Show triplets for 450 ms
          #  end;

             /* Do the same thing again, if you thing you'll have to present 4 words at a time.
               But comment this out if you don't have triplets.  Saves time!!!
            */
          #  V_Underscore_Index = A_Stimulus_Words[V_Current_Word].find("_");
          #  if V_Underscore_Index != 0 then
          #      A_Stimulus_Words[V_Current_Word].set_char(V_Underscore_Index, 32);
          #      T_Visual_Stimulus.set_duration(550);  # Show triplets for 450 ms
          #  end;

            /* If there are critical words, at the beginning of which a trigger needs to be sent,
                these will be indicated with a star in the Visual-Stimulus text file.  However,
                when actually showing the word, this must be replaced by a space.  We do this,
                and send an event code to the logfile as well as a port code to EEG.
            */
            V_Star_Index = A_Stimulus_Words[V_Current_Word].find("*");
            if V_Star_Index != 0 then
                A_Stimulus_Words[V_Current_Word].set_char(V_Star_Index, 32);
                V_Condition_Code = string(int(V_Condition_Code) + 1);
                E_Visual_Stimulus.set_event_code(V_Condition_Code);
                E_Visual_Stimulus.set_port_code(int(V_Condition_Code));
            end;

            T_Blank_Screen.present();

            # Put the current word on the picture and redraw the text part in it.
				Txt_Visual_Stimulus.set_caption(A_Stimulus_Words[V_Current_Word]);
            Txt_Visual_Stimulus.redraw();

            # Present the trial that will show the changed text on screen for x ms.
            T_Visual_Stimulus.present();

            # Reset things before going to the next word!
            E_Visual_Stimulus.set_event_code("");
            E_Visual_Stimulus.set_port_code(port_code_none);
            T_Visual_Stimulus.set_duration(400);

            # Go to the next word.
            V_Current_Word = V_Current_Word + 1;

        #=============
        # End Loop 2.2
        #=============
        end; /*** End Loop 2.2 for Stimulus Words ***/
        /*****************  Visual Stimulus Presentation Ends  *************************/

        # Duration for the Blank Screen between last stimulus word and ???
        T_Blank_Screen.set_duration(2000);
        T_Blank_Screen.present();


		# Present the trial that will show the recomposed Comprehension Question on screen for x ms.
        T_Show_Question_Mark.present();

        # Monitor the Response and send appropriate port codes to EEG!!!
        D_Stimulus_Data = stimulus_manager.last_stimulus_data();

        # To delay sending the following codes to the Output Port!!!
        # Because these are almost at the same time as the Response there, so the port
        # cannot handle it unless there's a short delay.
        if (D_Stimulus_Data.type() == stimulus_hit) then
            E_Response_Code_to_EEG.set_port_code(196);
            E_Response_Code_to_EEG.set_event_code("196");
            T_Response_Code_to_EEG.present();

        elseif (D_Stimulus_Data.type() == stimulus_incorrect) then
            E_Response_Code_to_EEG.set_port_code(197);
            E_Response_Code_to_EEG.set_event_code("197");
            T_Response_Code_to_EEG.present();

        elseif (D_Stimulus_Data.type() == stimulus_miss) then
            T_Report_Timeout_to_EEG.present();
            E_Response_Code_to_EEG.set_port_code(199);
            E_Response_Code_to_EEG.set_event_code("199");
            T_Response_Code_to_EEG.present();
        end;

		  # Reset Duration for the Blank Screen
        T_Blank_Screen.set_duration(1000);
        T_Blank_Screen.present();

        # Go to the Next Trial
        V_Current_Trial = V_Current_Trial + 1;

    #===========
    # End Loop 2
    #===========
    end; /*** End Loop 2 for Trials ***/

# Go to the Next Block
V_Current_Block = V_Current_Block + 1;

#================
# End Main Loop 1
#================
end;    /*** End Main Loop 1 for Blocks ***/

# Close all the open files
F_Session_List.close();
F_Visual_Stimulus.close();


# Finish off the session!!!
T_End_Thanks.present();
