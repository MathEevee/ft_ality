let check_Arg argv =
	let argc = Array.length argv in
	match argc with
	| 1 ->
		Print.print_Error "Usage : ./ft_ality <grammar_file>";
		false
	| 2 ->
		true
	| _ ->
		Print.print_Error "Error : Too many arguments";
		false

let init_Window width height =
	match Tsdl.Sdl.init Tsdl.Sdl.Init.video with
	| Error (`Msg e) -> Print.print_Error ("Erreur SDL :" ^ e);
		exit 1
	| Ok () -> ();

	match Tsdl.Sdl.create_window
		~w:width
		~h:height
		"Keyboard Window"
		Tsdl.Sdl.Window.shown
	with
	| Error (`Msg e) -> Print.print_Error ("Erreur SDL :" ^ e);
		exit 1
	| Ok win -> win

let () =
	let argv = Sys.argv in
	if not (check_Arg argv) then
		exit 1;

	let (automate, alphabet) = Automate.create_Automate argv.(1) in
	if alphabet = [] then
		exit 1;

	let window = init_Window 400 200 in
	match Keyboard.create_Key_Mapping alphabet with
	| None ->
			Tsdl.Sdl.destroy_window window;
			Tsdl.Sdl.quit ()
	| Some key_mapping ->
		Print.print_Key_Mapping key_mapping;
		Automate.launch_Automate automate key_mapping;
		Tsdl.Sdl.destroy_window window;
		Tsdl.Sdl.quit ()
