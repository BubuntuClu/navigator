class Building < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.address_changed? }


  def full_address
    ['Москва', address].compact.join(', ')
  end
end

# var lat1 = 55.737324
# var lon1 = 37.609038

# var lat2 = 55.739823
# var lon2 = 37.610134

# var R = 6371e3; // metres
# var φ1 = lat1.toRadians();
# var φ2 = lat2.toRadians();
# var Δφ = (lat2-lat1).toRadians();
# var Δλ = (lon2-lon1).toRadians();

# var x = Δλ * Math.cos((φ1+φ2)/2);
# var y = (φ2-φ1);
# var d = Math.sqrt(x*x + y*y) * R;



# var lat1 = 55.737324
# var lat2 = 55.744515
# var lon1 =37.609038
# var lon2 = 37.550136

# var lat1 = 55.737324
# var lon1 = 37.609038

# var lat2 = 55.739823
# var lon2 = 37.610134

# var R = 6371e3; // metres
# var φ1 = lat1.toRadians();
# var φ2 = lat2.toRadians();
# var Δφ = (lat2-lat1).toRadians();
# var Δλ = (lon2-lon1).toRadians();


# var a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
#         Math.cos(φ1) * Math.cos(φ2) *
#         Math.sin(Δλ/2) * Math.sin(Δλ/2);
# var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

# var d = R * c;


# 9,"ул. Крымский Вал, вл. 2",55.737324,37.609038,0.0
# 60,"наб. Болотная, д. 3, стр. 1",55.739823,37.610134,0.156345150499788

# 46,"Кутузовский просп., д. 21, стр.1",55.744515,37.550136,6580.1578433347



# 55.737324 * Math::PI / 180


# 9,"ул. Крымский Вал, вл. 2",55.737324,37.609038,0.0,0.0
# 60,"наб. Болотная, д. 3, стр. 1",55.739823,37.610134,0.156345150499788,251.61250450533
