export type TabType = 'weather' | 'time' | 'schedule';

export interface WeatherTypeItem {
  id: string;
  name: string;
  category: string;
  icon: string;
}

export interface WeatherManagerSettings {
  freezeWeather: boolean;
  instantChange: boolean;
  enableBlackout: boolean;
  forceSnow: boolean;
}

export interface TimeSettings {
  hours: number;
  minutes: number;
  freezeTime: boolean;
  timeScale: number;
}

export interface EnvironmentalData {
  temperature: number;
  feelsLike: number;
  windPercentage: number;
  humidity: number;
  currentWeather: string;
  dayName: string;
  currentTime: string;
  locationName: string;
  currentDate: string;
}

export interface ScheduleItem {
  id: string;
  weather: string;
  time: string;
  durationMinutes: number;
}
