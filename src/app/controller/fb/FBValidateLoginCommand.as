package app.controller.fb{	import app.services.FacebookService;	import org.robotlegs.mvcs.Command;	/**	 * @author marco link (m.link@gmx.de)	 */	public class FBValidateLoginCommand extends Command	{		/*******************************************************************************************		*								public properties										   *		*******************************************************************************************/		[Inject]		public var service : FacebookService;						/*******************************************************************************************		*								protected/ private properties							   *		*******************************************************************************************/						/*******************************************************************************************		*								public methods											   *		*******************************************************************************************/		public function FBValidateLoginCommand()		{					}				override public function execute() : void		{			service.validateLogin();		}								/*******************************************************************************************		*								protected/ private methods								   *		*******************************************************************************************/	}}