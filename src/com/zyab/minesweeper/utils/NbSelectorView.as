package com.zyab.minesweeper.utils
{
	import com.zyab.minesweeper.events.EventsList;
	
	import feathers.controls.Label;
	import feathers.controls.Slider;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import com.zyab.minesweeper.Constants;
	
	// Class displaying a number selector (slider) with labels containing its name, min value, max value and current value
	
	public class NbSelectorView extends Sprite
	{
		private var slider:Slider;
		private var minLabel:Label;
		private var maxLabel:Label;
		private var valueLabel:Label;
		private var selectLabel:Label;
		public static const NB_SELECTOR_CHANGE:String = "nbSelectorChange";
		
		public function NbSelectorView(text:String,min:int,max:int,step:int = 1):void
		{
			slider = new Slider();
			slider.minimum = min;
			slider.maximum = max;
			slider.step = step;
			slider.value = (min+max)/2;
			slider.step = step;
			slider.x = Constants.STAGE_WIDTH/4;
			slider.width = Constants.STAGE_WIDTH/2;
			addChild(slider);
			
			minLabel = new Label();
			minLabel.text = ""+min;
			minLabel.x = slider.x;
			addChild(minLabel);
			
			maxLabel = new Label();
			maxLabel.text = ""+max;
			maxLabel.x = slider.x+slider.width;
			addChild(maxLabel);
			
			valueLabel = new Label();
			valueLabel.text = ""+slider.value;
			valueLabel.x = 300;
			addChild(valueLabel);
			
			selectLabel = new Label();
			selectLabel.text = text;
			selectLabel.x = 10;
			addChild(selectLabel);
			
			slider.addEventListener(Event.CHANGE,valueIsChanged);
		}
		
		public function checkValue():void{
			if(slider.value > slider.maximum) slider.value = slider.maximum;
			if(slider.value < slider.minimum) slider.value = slider.minimum;
		}
		
		public function setMaximum(max:int):void{
			this.slider.maximum = max;
			this.maxLabel.text = max+"";
			
		}
		
		public function getValue():int{
			return this.slider.value;
		}
		
		public function setValue(value:int):void{
			this.slider.value = value;
		}
		
		public function getMax():int{
			return this.slider.maximum;
		}
		
		public function getMin():int{
			return this.slider.minimum;
		}
		
		private function valueIsChanged(event:Event):void{
			
			var changingSlider:Slider = event.currentTarget as Slider;;
			if(changingSlider!=null){
				valueLabel.text=""+changingSlider.value;
			}
			dispatchEventWith(NB_SELECTOR_CHANGE, true);
		}
	}
}