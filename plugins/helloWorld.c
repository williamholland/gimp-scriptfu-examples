#include <libgimp/gimp.h>

/*  Local function prototypes  */

static void   query (void);
static void   run   (const gchar      *name,
			gint              nparams,
			const GimpParam  *param,
			gint             *nreturn_vals,
			GimpParam       **return_vals);



/*  This structure has to have that name. It contains four pointers to
 *  functions, which will be called at set times of the plug-in life. init and
 *  quit are optional, and thus can hold NULL values, but the last two
 *  functions, query and run, are mandatory. */
GimpPlugInInfo PLUG_IN_INFO =
{
  NULL,  /* init_proc  */
  NULL,  /* quit_proc  */
  query, /* query_proc */
  run,   /* run_proc   */
};

MAIN ()

static void query (void)
{
	static GimpParamDef args[] = {
		{
			GIMP_PDB_INT32,
			"run-mode",
			"Run mode"
		},
		{
			GIMP_PDB_IMAGE,
			"image",
			"Input image"
		},
		{
			GIMP_PDB_DRAWABLE,
			"drawable",
			"Input drawable"
		}
	};

	gimp_install_procedure (
		"plug-in-hello",
		"Hello, world!",
		"Displays \"Hello, world!\" in a dialog",
		"David Neary",
		"Copyright David Neary",
		"2004",
		"_Hello world...",
		"RGB*, GRAY*",
		GIMP_PLUGIN,
		G_N_ELEMENTS (args), 0,
		args, NULL);

		gimp_plugin_menu_register ("plug-in-hello", "<Image>/Filters/Misc");
}

static void run (const 	gchar		*name,
			gint		nparams,
			const GimpParam	*param,
			gint		*nreturn_vals,
			GimpParam	**return_vals)
{
	static GimpParam	values[1];
	GimpPDBStatusType status = GIMP_PDB_SUCCESS;
	GimpRunMode			 run_mode;

	/* Setting mandatory output values */
	*nreturn_vals = 1;
	*return_vals	= values;

	values[0].type = GIMP_PDB_STATUS;
	values[0].data.d_status = status;

	/* Getting run_mode - we won't display a dialog if we are in *
 	 * NONINTERACTIVE mode */

	run_mode = param[0].data.d_int32;

	if (run_mode != GIMP_RUN_NONINTERACTIVE)
		g_message("Hello, world!\n");
}
