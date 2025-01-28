import { View, Text, SafeAreaView, TouchableOpacity } from "react-native";
import React from "react";
import AntDesign from "@expo/vector-icons/AntDesign";
import { router } from "expo-router";

export default function tourneypage() {
  const exampleTraining = {
    "Baseline Patterns": {
      "Warm Up": {
        drills: [
          "Mini Tennis - 30 balls in a row",
          "Baseline cross court - 20 Ball in a row",
          "Serve warm up each side x10",
        ],
        notes: [
          "Warm up with good rhythm, height and consistency, adjust to each opponent's ball.",
        ],
      },
      "Main Drills": {
        drills: [
          "The 2-1, hit 2 FH cross court and 1 FH down the line x10",
          "The 2-1, hit 2 BH cross court and 1 BH down the line x10",
          "Play points with the patterns above",
        ],
        notes: ["The 2-1 is the favorite baseline strategy of the pro’s."],
      },
    },
  };

  const warmUpDrills = exampleTraining["Baseline Patterns"]["Warm Up"].drills;
  const mainDrills = exampleTraining["Baseline Patterns"]["Main Drills"].drills;
  const notes = exampleTraining["Baseline Patterns"]["Main Drills"].notes;
  const titleName = Object.keys(exampleTraining);
  return (
    <SafeAreaView className="bg-bgColor flex-1">
      <View className="mx-6">
        <View className="flex-row items-center ">
          <TouchableOpacity onPress={() => router.back()}>
            <AntDesign name="arrowleft" size={24} color="white" />
          </TouchableOpacity>
          <Text className="text-slate-300 text-center text-2xl font-medium mt-2 flex-1">
            {titleName}
          </Text>
        </View>
        <View className="bg-slate-800 mt-5 p-3 rounded-xl border border-slate-500">
          <Text className="text-blue-300 text-xl pl-3 font-semibold">
            Warm Up
          </Text>
          <View className="flex-col gap-3 pl-3 mt-3">
            {warmUpDrills.map((item, index) => (
              <Text
                key={index}
                className="text-slate-300 text-lg"
                style={{ marginVertical: 5 }}
              >
                {index + 1}. {item}
              </Text>
            ))}
          </View>
        </View>
        <View className="bg-slate-800 mt-5 p-3 rounded-xl border border-slate-500">
          <Text className="text-blue-300 text-xl pl-3 font-semibold">
            Main Drill
          </Text>
          <View className="flex-col gap-3 pl-3 mt-3">
            {mainDrills.map((item, index) => (
              <Text
                key={index}
                className="text-slate-300 text-lg"
                style={{ marginVertical: 5 }}
              >
                - {item}
              </Text>
            ))}
          </View>
        </View>
        <View className="bg-slate-800 mt-5 p-3 rounded-xl border border-slate-500">
          <Text className="text-blue-300 text-xl pl-3 font-bold">Note</Text>
          <View className="flex-row gap-3 pl-3 mt-3 pb-2">
            {notes.map((item, index) => (
              <Text
                key={index}
                className="text-slate-300 text-[15px] leading-[20px]"
                style={{ marginVertical: 5 }}
              >
                {item}
              </Text>
            ))}
          </View>
        </View>

        <TouchableOpacity>
          <Text
            onPress={() => router.back()}
            className="text-center bg-teal-500 rounded-xl p-4 mt-6 text-white font-bold text-xl"
          >
            Complete
          </Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}
