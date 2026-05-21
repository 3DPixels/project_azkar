import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodPrayerCard extends StatefulWidget {
  const MoodPrayerCard({super.key});

  @override
  State<MoodPrayerCard> createState() => _MoodPrayerCardState();
}

class _MoodPrayerCardState extends State<MoodPrayerCard> {
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: BoxBorder.all(color: Color(0xFF1E293B)),
        color: Color(0xFF1A202C),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton.filled(
                  onPressed: () {
                    setState(() {
                      playing = !playing;
                    });
                  },
                  iconSize: 35,
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF2B6CEE,
                    ).withValues(alpha: .1),
                    foregroundColor: const Color(0xFF2B6CEE),
                  ),
                  icon: Icon(playing ? Icons.pause : Icons.play_arrow_outlined),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(
                        'اللَّهُمَّ إِنِّي عَبْدُكَ، ابْنُ عَبْدِكَ،ابْنُ أَمَتِكَ، نَاصِيَتِي بِيَدِكَ،مَاضٍ فِيَّ حُكْمُكَ اللَّهُمَّ إِنِّي عَبْدُكَ، ابْنُ عَبْدِكَ،ابْنُ أَمَتِكَ، نَاصِيَتِي بِيَدِكَ،مَاضٍ فِيَّ حُكْمُكَ',
                        style: GoogleFonts.notoSansArabic(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xFF334155).withValues(alpha: .5),
                      ),
                      Text(
                        '"O Allah, I am Your slave, son of Yourslave, son of Your female slave, myforelock is in Your hand..."',
                        textDirection: TextDirection.ltr,
                        style: GoogleFonts.inter(
                          color: Color(0xFF94A3B8),
                          fontSize: 15,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF2B6CEE),
                          textStyle: GoogleFonts.notoSansArabic(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        label: Text('حصن المسلم'),
                        icon: Icon(Icons.menu_book_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              border: BorderDirectional(
                top: BorderSide(color: Color(0xFF1E293B)),
              ),
              color: Color(0xFF151A23),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                  color: Color(0xFF94A3B8),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.copy_rounded),
                  color: Color(0xFF94A3B8),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                  color: Color(0xFF94A3B8),
                ),
                Spacer(),
                Text(
                  'Dua #1',
                  style: GoogleFonts.inter(
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
