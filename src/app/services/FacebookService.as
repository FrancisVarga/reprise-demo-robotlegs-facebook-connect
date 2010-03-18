package app.services{	import flash.events.TimerEvent;
	import flash.utils.Timer;	import app.events.fb.FBConnectEvent;	import com.facebook.Facebook;	import com.facebook.commands.users.GetInfo;	import com.facebook.data.users.FacebookUser;	import com.facebook.data.users.GetInfoData;	import com.facebook.data.users.GetInfoFieldValues;	import com.facebook.events.FacebookEvent;	import com.facebook.net.FacebookCall;	import com.facebook.utils.FacebookSessionUtil;	import org.robotlegs.mvcs.Actor;	import flash.display.Stage;	/**	 * @author marco link (m.link@gmx.de)	 */	public class FacebookService extends Actor	{		/*******************************************************************************************		*								public properties										   *		*******************************************************************************************/		[Inject] public var stage : Stage;				public static const API_KEY : String = 'XXX';		public static const SECRET_KEY : String = 'XXX';
						/*******************************************************************************************		*								protected/ private properties							   *		*******************************************************************************************/		private var m_session : FacebookSessionUtil;
		private var m_facebook : Facebook;
		private var m_user : FacebookUser;		private var m_timer : Timer;
				/*******************************************************************************************		*								public methods											   *		*******************************************************************************************/		public function FacebookService()		{					}
		public function login() : void		{			if(!m_session)			{				initService();			}			m_session.login();			m_timer = new Timer(1000);			m_timer.start();			m_timer.addEventListener(TimerEvent.TIMER, timer_tick);		}		public function validateLogin() : void		{			if(!m_session)			{				initService();			}        	m_session.validateLogin();		}				public function getUserData() : FacebookUser		{			return m_user;		}						/*******************************************************************************************		*								protected/ private methods								   *		*******************************************************************************************/		protected function initService() : void 		{			m_session = new FacebookSessionUtil(API_KEY, SECRET_KEY, stage.loaderInfo);			m_session.addEventListener(FacebookEvent.CONNECT, login_connect);			m_facebook = m_session.facebook;		}
		private function timer_tick(event : TimerEvent) : void 		{			m_session.validateLogin();		}				private function login_connect(event : FacebookEvent) : void 		{						if(!event.success)			{				return;				}			m_session.removeEventListener(FacebookEvent.CONNECT, login_connect);			var call:FacebookCall = m_facebook.post(new GetInfo([m_facebook.uid], 
				[GetInfoFieldValues.ALL_VALUES]));			call.addEventListener(FacebookEvent.COMPLETE, login_info);		}				private function login_info(e:FacebookEvent):void		{			m_timer.stop();			m_timer.removeEventListener(TimerEvent.TIMER, timer_tick);			m_user = (e.data as GetInfoData).userCollection.getItemAt(0) as FacebookUser;			e.target.removeEventListener(FacebookEvent.COMPLETE, login_info);			dispatch(new FBConnectEvent(FBConnectEvent.FB_CONNECT_SUCCESS));		}	}}