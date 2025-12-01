import 'package:students_control/features/courses/data/model/schedule_model.dart';
import 'package:students_control/features/courses/domain/entities/schedule.dart';

class ScheduleMapper {
  static Schedule toEntity(ScheduleModel model) {
    return Schedule(
      id: model.id,
      courseId: model.courseId,
      dayOfWeek: model.dayOfWeek,
      startTime: model.startTime,
      endTime: model.endTime,
      classroom: model.classroom,
    );
  }

  static ScheduleModel toModel(Schedule entity) {
    return ScheduleModel(
      id: entity.id,
      courseId: entity.courseId,
      dayOfWeek: entity.dayOfWeek,
      startTime: entity.startTime,
      endTime: entity.endTime,
      classroom: entity.classroom,
    );
  }
}
